import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-type-search"
export default class extends Controller {
  static targets = ["card"]
  static values = { game: Number }

  url = `favorites/${this.gameTarget}`

  remove(event) {
    event.preventDefault()
    if (event.target.innerText == "🖤") {
      event.target.innerText = "🧡";
      fetch("favorites/#{}")
    } else
      event.target.innerText = "🖤";
  }

  add(event) {
    event.preventDefault()
    if (event.target.innerText == "🖤") {
      event.target.innerText = "🧡";
    } else
      event.target.innerText = "🖤";
  }
}
