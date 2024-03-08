class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to events_path if user_signed_in?
  end

  def dashboard
  end

  def leaderboard
  end

  def user_events
  end

  def map
    @games = current_user.games
    @favorite_events = get_events_for_favorite_games(@games)

    @events = @events.global_search(params[:query]) if params[:query].present?
    @events = @events.global_search(params[:event_type]) if params[:event_type].present?
    @events = @events.global_search(params[:dates]) if params[:dates].present?
    @events = @events.global_search(params[:location]) if params[:location].present?

    @markers = @favorite_events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {event: event}),
        marker_html: render_to_string(partial: 'marker', locals: {event: event})
      }
    end
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
