class EventsController < ApplicationController
  before_action :set_events, only: [:show, :edit, :update, :destroy]

  # link_to de la show de GamesController qui envoie vers la Route "/events"
  def index
    @games = current_user.games # jeux favoris du current_user
    @favorite_events = get_events_for_favorite_games(@games) # evenements des jeux fav
    @other_events = Event.all.reject { |event| @favorite_events.include?(event) }


    @events = Event.all
    #search-bar and filters query below
    @events = @events.global_search(params[:query]) if params[:query].present?
    @events = @events.global_search(params[:event_type]) if params[:event_type].present?
    @events = @events.global_search(params[:dates]) if params[:dates].present?
    @events = @events.global_search(params[:location]) if params[:location].present?

    # The `geocoded` scope filters only events with coordinates
    # @favorite_markers = fetch_markers(@favorite_events)
    # @other_events_markers = fetch_markers(@other_events)

  end

  # Link_to de l'action index juste au dessus et qui envoie vers l'évènements correspondant sur /events/:id
  def show
    # Si event vient bien de current user, alors on ajoute une feature dans la show pour rediriger vers edit
    @is_user_game = false
    current_user.games.each do |game|
      if @game == game
        @is_user_game = true
      end
    end
    # Variable d'instance crée pour afficher le button "edit event"
  end

  # Link_to de l'action index des events qui envoie vers la création d'un nouvel évènement
  def new
    @event = Event.new
  end

  # new renvoie vers la route create qui redirige auto vers le dashboard
  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to dashboard_path(@event)
  end

  # 2 routes possible qui envoie vers edit, 1 depuis l'index des events et l'autre depuis le dashboard peut être
  def edit
    # verifier que l'event correspond bien a current user ?
  end

  def update

  end

  def destroy

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
    # Event.where(id: events.flatten.map(&:id))
    Event.where(id: events.flatten.map(&:id))

  end

  def set_events
    @event = Event.find(params[:id])
  end

  def event_params

  end
end
