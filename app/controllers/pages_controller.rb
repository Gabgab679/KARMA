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

    @events = current_user.events_participations

    @events = @events.global_search(params[:query]) if params[:query].present?
    @events = @events.global_search(params[:event_type]) if params[:event_type].present?
    @events = @events.global_search(params[:dates]) if params[:dates].present?
    @events = @events.global_search(params[:location]) if params[:location].present?

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {event: event}),
        marker_html: render_to_string(partial: 'marker', locals: {event: event})
      }
    end

  end
end
