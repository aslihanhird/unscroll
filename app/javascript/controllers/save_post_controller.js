import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="save-post"
export default class extends Controller {
  static targets = ["iconLink"]
  connect() {

  }

  changeIcon(event) {
    event.preventDefault();



    this.iconLinkTarget.innerHTML = '<i class="fa-solid fa-bookmark primary-color"></i>';

  }
}
