class FavoritesController < ApplicationController
  def create
    new_fav = Favorite.new
    new_fav.user = current_user
    if params[:id]
      new_fav.game = Game.find(params[:id])
      new_fav.save
      respond_to do |format|
        format.json { render json: { status: :ok } }
      end
    else
      new_fav.game = Game.find(params[:format])
      new_fav.save
      redirect_to game_path(new_fav.game)
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.favorites.each do |favorite|
      favorite.destroy if favorite.user == current_user
    end

    redirect_to game_path(game)
  end
  respond_to do |format|
    format.json { render json: { status: :ok } }
  end
end
