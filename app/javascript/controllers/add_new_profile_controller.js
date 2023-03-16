import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-new-profile"
export default class extends Controller {

  static targets = ["igIcon", "twIcon", "igForm", "twForm", "pagebody", "background"]

  connect() {

  }

  instaClick(event) {
    if (!this.igIconTarget.classList.contains("selected")) {
      // Select the IG icon
      this.igIconTarget.classList.add("selected");

      // Deselect the TW icon
      this.twIconTarget.classList.remove("selected");


      // Show the IG form
      this.igFormTarget.classList.remove("d-none");

      // Hide the TW form
      this.twFormTarget.classList.add("d-none");

      // Set the background to red
      this.backgroundTarget.classList.remove("active");

    }
  }

  twitterClick(event) {
    if (!this.twIconTarget.classList.contains("selected")) {
      this.twIconTarget.classList.add("selected");
      this.twFormTarget.classList.remove("d-none");
      this.igFormTarget.classList.add("d-none");
      this.igIconTarget.classList.remove("selected");

      this.backgroundTarget.classList.add("active");
    }
  }
}
