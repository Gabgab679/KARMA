import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-type-search"
export default class extends Controller {
  static targets = ["casualButtonElement", "tournamentButtonElement"]

  connect() {
    console.log("oui");
  }
  toggleCasualButton() {
    this.casualButtonElement.classList.toggle("karma-button-rose");
    /* Si casualButtonElement classlist contient karma button rose
    alors on supprime Karma Button rose pour tournament button element */
    this.tournamentButtonElement.classList.remove("karma-button-rose");
    console.log("tu passes bien par là");
  }

  toggleTournamentButton() {
    this.tournamentButtonElement.classList.toggle("karma-button-rose");
    /* Si casualButtonElement classlist contient karma button rose
    alors on supprime Karma Button rose pour tournament button element */
    this.casualButtonElement.classList.remove("karma-button-rose");
    console.log("là aussi");
  }
}
