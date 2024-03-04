class EventsController < ApplicationController
  before_action :set_events, only: [:show, :edit, :update, :destroy]

  # link_to de la show de GamesController qui envoie vers la Route "/events"
  def index
    @game = Game.find(params[:id]) # On cherche la game correspondant à l'id passé en params du link to de la show de games/:id
    @events = @game.events
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

  # 2 routes possible qui envoie vers edit, depuis le dashboard
  def edit
    # verifier que l'event correspond bien a current user ?
  end

  def update

  end

  def destroy

  end

  private

  def set_events
    @event = Event.find(params[:id])
  end

  def event_params

  end
end
