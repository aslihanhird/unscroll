import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = ["post"]

  connect() {
    // Remove d-none only from the very first post
    this.postTarget.classList.remove("d-none");
    this.postTarget.classList.add("displayed");

  }

  previous(event) {

  }

  next(event) {
    event.preventDefault();

    const targets = this.postTargets;
    const current_post_index = targets.findIndex(post => post.classList.contains("displayed"));

    // current_post_index.classList.add("d-none");
    targets[current_post_index].classList.add("d-none");
    targets[current_post_index].classList.remove("displayed");

    targets[current_post_index + 1].classList.remove("d-none");
    targets[current_post_index + 1].classList.add("displayed");

  }
}
