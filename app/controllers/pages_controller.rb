class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if user_signed_in?
      @user_is_connected = true
    else
      @user_is_connected = false
    end
    # TODO: Si utilisateur est connecté redirect to events_
  end

  def dashboard
    @user = current_user
  end

  def leaderboard
  end
end
