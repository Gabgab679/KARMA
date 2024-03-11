import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flatpicker-range"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      mode: "range",
      dateFormat: "Y-m-d"
    })
  }
}
