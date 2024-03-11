import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-tabs"
export default class extends Controller {

  static targets = ["leaderboardElement", "favoriteGameElement"]

  displayLeaderboard() {
    this.favoriteGameElementTarget.classList.add("d-none");
    this.leaderboardElementTarget.classList.remove("d-none");
  }

  displayFavoriteGames() {
    this.favoriteGameElementTarget.classList.remove("d-none");
    this.leaderboardElementTarget.classList.add("d-none");
  }
}
