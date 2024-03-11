import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="event-subscription"
export default class extends Controller {
  static values = { eventId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "EventChannel", id: this.eventIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
      )
    console.log(`Subscribe to the event with the id ${this.eventIdValue}.`)
  }

  resetForm(event) {
    event.target.reset()
  };

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data),
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  };

}
