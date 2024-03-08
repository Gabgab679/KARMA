class FavoritesController < ApplicationController
  def create
    new_fav = Favorite.new
    new_fav.user = current_user
    new_fav.game = Game.find(params[:format])
    new_fav.save
  end

  def destroy
    game = Game.find(params[:id])
    game.favorites.each do |favorite|
      favorite.destroy if favorite.user == current_user
    end
  end
end
