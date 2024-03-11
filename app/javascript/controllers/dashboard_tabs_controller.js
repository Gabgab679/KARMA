import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-tabs"
export default class extends Controller {

  static targets = ["leaderboardElement", "favoriteGameElement"]

  displayLeaderboard() {
    this.favoriteGameElementTarget.classList.add("d-none");
    this.leaderboardGameElementTarget.classList.remove("d-block");
  }

  displayFavoriteGame() {
    this.favoriteGameElementTarget.classList.add("d-block");
    this.leaderboardGameElementTarget.classList.remove("d-none");
  }
}
