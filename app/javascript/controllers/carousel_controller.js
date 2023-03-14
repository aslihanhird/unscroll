import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["media"]

  connect() {
    console.log("Carousel connected!");

    this.mediaTargets.slice(1).forEach((media) => {
      media.classList.add("d-none");
    })
  }

  test() {
    console.log("we made it");
  }

}
