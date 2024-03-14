import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-type-search"
export default class extends Controller {
  static values = { game: Number }


  toggle(event) {
    event.preventDefault()
    const url = `/favorites/${this.gameValue}`;
    const csrfToken = document.querySelector("[name='csrf-token']").content
    if (event.target.innerText == "🖤") {
      fetch("/favorites", {
        method: 'POST',
        headers: {
          "X-CSRF-Token": csrfToken,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ id: this.gameValue })
      })
      .then(response => {
        if (response.ok) {
          console.log(response.json);
        } else {
          throw new Error('Network response was not ok.');
        }
      })
      .then(response => {
        event.target.innerText = "❤️";
        $.jnotify()
      })
      .catch(error => console.error("Error:", error));
    } else {
      event.target.innerText = "🖤";
      fetch(url, {
        method: 'DELETE',
        headers: {
          "X-CSRF-Token": csrfToken,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ id: this.gameValue })
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error('Network response was not ok.');
        }
      })
      .then(response => {
      })
      .catch(error => console.error("Error:", error));
    }
  }
}
