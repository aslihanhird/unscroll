import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-new-profile"
export default class extends Controller {

  static targets = ["igIcon", "twIcon", "igForm", "twForm"]

  connect() {
    console.log("Connected")
  }

  clickig(event) {
    if (!this.igIconTarget.classList.contains("selected")) {
      this.igIconTarget.classList.add("selected");
      this.twIconTarget.classList.remove("selected");

      this.twFormTarget.classList.add("d-none");
      this.igFormTarget.classList.remove("d-none");
    }
  }

  twitterClick(event) {
    if (!this.twIconTarget.classList.contains("selected")) {
      this.twIconTarget.classList.add("selected");
      this.twFormTarget.classList.remove("d-none");
      this.igFormTarget.classList.add("d-none");
      this.igIconTarget.classList.remove("selected");
    }
  }
}
