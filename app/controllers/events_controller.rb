class EventsController < ApplicationController
  before_action :set_events, only: [:show, :edit, :update, :destroy]

  # link_to de la show de GamesController qui envoie vers la Route "/events"
  def index
    @games = current_user.games # jeux favoris du current_user
    @events_favorites = get_events_for_each_game(@games)  # evenements des jeux fav

    @events = Event.all
    #search-bar and filters query below
    @events = @events.global_search(params[:query]) if params[:query].present?
    @events = @events.global_search(params[:event_type]) if params[:event_type].present?
    @events = @events.global_search(params[:dates]) if params[:dates].present?
    @events = @events.global_search(params[:location]) if params[:location].present?

    # The `geocoded` scope filters only events with coordinates
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {event: event}),
        marker_html: render_to_string(partial: 'marker', locals: {event: event})
      }
    end
  end

  # Link_to de l'action index juste au dessus et qui envoie vers l'évènements correspondant sur /events/:id
  def show
    # Si event vient bien de current user, alors on ajoute une feature dans la show pour rediriger vers edit
    @event = Event.find(params[:id])
    @registered = false
    @event.participations.each do |participation|
      @registered = true if participation.user == current_user
    end
    # @is_user_game = false
    # current_user.games.each do |game|
    #   if @game == game
    #     @is_user_game = true
    #   end
    # end
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

  def get_events_for_each_game(games)
    events = []
    games.each do |game|
      events << game.events
    end
  end

  def set_events
    @event = Event.find(params[:id])
  end

  def event_params

  end
end
