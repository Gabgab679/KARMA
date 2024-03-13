class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to events_path if user_signed_in?
  end

  def dashboard
    @games = Game.all
    @other_games = @games.reject { |game| current_user.games.include?(game) }
  end
  
  def leaderboard
  end

  def user_events

    @pending_request = current_user.request_participations.where(status: "Pending")
  end

  def map
    @events = Event.all
    @games = current_user.games
    @favorite_events = get_events_for_favorite_games(@games)

    @events = @events.global_search(params[:query]) if params[:query].present?
    @events = @events.where(event_type: params[:event_type]) if params[:event_type].present?

    if params[:date].present?
      first_date, last_date = *params[:date].split(" to ")
      @events = @events.where("date >= ?", first_date).where("date <= ?", last_date)
    end

    @events = @events.global_search(params[:location]) if params[:location].present?

    if params[:my_events] == "true"
      @events = @events.joins(:participations).where(participations: { user_id: current_user.id })
    end

    @fav_markers = @favorite_events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {event: event}),
        marker_html: render_to_string(partial: 'marker', locals: {event: event})
      }
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {event: event}),
        marker_html: render_to_string(partial: 'marker', locals: {event: event})
      }
    end
  end

  def chatrooms
    @events_participations = current_user.events_participations
    #current_user.events_participations ##tous les events où l'user est inscrit, mais qu'il n'a pas crées
    @created_events = current_user.events
  end

  private

  def get_events_for_favorite_games(games)
    events_collection_per_game = []

    games.each do |game|
      events_collection_per_game << game.events
    end
    # Event.where(id: events.flatten.map(&:id))
    Event.where(id: events_collection_per_game.flatten.map(&:id))
  end
end
