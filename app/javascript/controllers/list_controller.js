import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="list"
export default class extends Controller {
  static targets = ["main", "options", "viewOptions", "back"]

  connect() {

  }

  showOptions(event) {
    this.mainTarget.classList.toggle("d-none");
    this.optionsTarget.classList.toggle("d-none");
    this.viewOptionsTarget.classList.toggle("d-none");
    this.backTarget.classList.toggle("d-none");
  }
}
