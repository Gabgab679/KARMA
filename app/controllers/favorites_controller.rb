class FavoritesController < ApplicationController
  def create
    new_fav = Favorite.new
    new_fav.user = current_user
    new_fav.game = Game.find(params[:format])
    flash[:alert] = " added to your favorites"
  end

  def destroy
    game = Game.find(params[:id])
    game.favorites.each do |favorite|
      favorite.destroy if favorite.user == current_user
    end
    flash.notice = "#{game.name} deleted from your favorites"
  end
end
