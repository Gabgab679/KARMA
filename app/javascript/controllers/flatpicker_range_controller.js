import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flatpicker-range"
export default class extends Controller {
  connect() {
    console.log("hello");
    flatpickr(this.element, {
      mode: "range",
      dateFormat: "d-m-Y"
    })
  }
}
