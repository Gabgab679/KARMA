import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["leaderboardElement", "favoriteGameElement", "favoriteGamesButton", "leaderboardButton"]

  connect() {
    // Ajouter la classe karma-button-rose au bouton Favorite Games au chargement de la page
    this.favoriteGamesButtonTarget.classList.add("karma-button-rose")
  }

  displayLeaderboard() {

    // Masquer l'élément Favorite Games
    this.favoriteGameElementTarget.classList.add("d-none")
    // Afficher l'élément Leaderboard
    this.leaderboardElementTarget.classList.remove("d-none")
    

    // Supprimer la classe karma-button-rose du bouton leaderbord
    this.leaderboardButtonTarget.classList.remove("karma-button-violet")
    // Ajouter la classe karma-button-rose au bouton Leaderboard
    this.leaderboardButtonTarget.classList.add("karma-button-rose")

    // Supprimer la classe karma-button-rose du bouton Favorite Games
    this.favoriteGamesButtonTarget.classList.remove("karma-button-rose")
    // Ajouter la classe karma-button-violet au bouton Favorite Games
    this.favoriteGamesButtonTarget.classList.add("karma-button-violet")
  }

displayFavoriteGames() {
    // Masquer l'élément Leaderboard
    this.leaderboardElementTarget.classList.add("d-none")
    // Afficher l'élément Favorite Games
    this.favoriteGameElementTarget.classList.remove("d-none")

    // Supprimer la classe karma-button-rose du bouton favorite
    this.favoriteGamesButtonTarget.classList.remove("karma-button-violet")
    // Ajouter la classe karma-button-rose au bouton Favorite Games
    this.favoriteGamesButtonTarget.classList.add("karma-button-rose")

    // Supprimer la classe karma-button-rose du bouton Leaderboard
    this.leaderboardButtonTarget.classList.remove("karma-button-rose")
    // Ajouter la classe karma-button-violet au bouton Leaderboard
    this.leaderboardButtonTarget.classList.add("karma-button-violet")
  }
}
