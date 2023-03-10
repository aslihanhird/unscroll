import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-new-profile"
export default class extends Controller {

  static targets = ["igIcon", "twIcon", "igForm", "twForm", "pagebody"]

  connect() {
    // Set the body color to red only on the specific page
    if (window.location.pathname.endsWith("new/select")) {
      document.querySelector("body").classList.add('insta-gradient');
    }

  }

  clickig(event) {
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
      document.querySelector('body').classList.add('insta-gradient');
      document.querySelector('body').classList.remove('twitter-gradient');
    }
  }

  twitterClick(event) {
    if (!this.twIconTarget.classList.contains("selected")) {
      this.twIconTarget.classList.add("selected");
      this.twFormTarget.classList.remove("d-none");
      this.igFormTarget.classList.add("d-none");
      this.igIconTarget.classList.remove("selected");

      document.querySelector('body').classList.remove('insta-gradient');
      document.querySelector('body').classList.add('twitter-gradient');
    }
  }
}
