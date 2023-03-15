import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="next"
export default class extends Controller {
  static targets = ["post"]

  connect() {

  }

  nextPost() {
    this.postTarget.classList.add("d-none")
  }

  previousPost() {
    let previousId = this.postTarget.id-1;
    if (previousId >= 1) {
      document.getElementById(previousId).classList.remove("d-none");
    }
  }

}
