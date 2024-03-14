class EventsController < ApplicationController
  before_action :set_events, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
    @games = current_user.games
    @favorite_events = get_events_for_favorite_games(@games)

    @events = @events.global_search(params[:query]) if params[:query].present?
    if params[:date].present?
      first_date, last_date = *params[:date].split(" to ")
      @events = @events.where("date >= ?", first_date).where("date <= ?", last_date)
    end
    @events = @events.global_search(params[:location]) if params[:location].present?
    @events = @events.sort_by(&:date).select { |event| @favorite_events.include?(event) }
    @events = @events.reject {|event| event.status != "Open" }
  end

  def show
    @registered = false
    @event.participations.each do |participation|
      @registered = true if participation.user == current_user
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.status = "Open"
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    redirect_to @event, notice: "No access to this page" if current_user != @event.user
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Your event has been updated"
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.update(status: 'Cancelled')
      redirect_to @event, notice: "You cancelled this event 😢"
    else
      render :new, notice: "Oops, something went wrong"
    end
  end

  private

  def fetch_markers(events)
    events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {event: event}),
        marker_html: render_to_string(partial: 'marker', locals: {event: event})
      }
    end
  end

  def get_events_for_favorite_games(games)
    events_collection_per_game = []

    games.each do |game|
      events_collection_per_game << game.events
    end
    Event.where(id: events_collection_per_game.flatten.map(&:id))
  end

  def set_events
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date, :address, :game_id, :max_players, :event_type)
  end
end
