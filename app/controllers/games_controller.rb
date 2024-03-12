class GamesController < ApplicationController
  #Depuis home, petit chargement qui envoie sur index
  def index
    @games = Game.all
    @favorite_games = current_user.games
     # Self explanatory cette fonction :)
    # @upcoming_game_events = get_upcoming_game_events(@games)
  end

  def show
    @game = Game.find(params[:id])
  end
end
  private

  def addFavorite
    @game = Game.find(params[:id])
    respond_to do |format|
      if @game.save
        format.html { redirect_to dashboard_path(@game) }
        format.text { render 'cards-game', locals: { game: @game }, formats: [:html] }
      else
        format.html { render :dashboard, status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end
#   def get_user_favorite_games(games) ####CETTE FONCTION EST L'EQUIVALENT DE ### CURRENT_USER.GAMES ###
#     favorite_games = []
#     games.each do |game|
#       favorite_games << game if current_user.favorites.include?(game)
#       # On itère sur games et on verifie que la game est bien inclue dans les favoris pour l'envoyer dans favorite_games
#     end
#     favorite_games #On retourne favorite games à @favorite_games
#   end

#   def get_upcoming_game_events(games)
#     upcoming_game_events = []
#     games.each do |game|
#       upcoming_game_events << game unless game.events.nil?
#     end
#     upcoming_game_events
#   end
# end
