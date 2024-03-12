import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-type-search"
export default class extends Controller {
  static targets = ["card"]
  static values = { game: Number }

  remove() {
    console.log("remove");
  }

  add() {

  console.log(this.gameValue);

  fetch(this.cardTarget.action, { headers: { "Accept": "text/plain" }})
    .then(response => response.text())
    .then((data) => {
      console.log(data);
    })
  }
}
