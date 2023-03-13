import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = ["post", "previous", "next", "fullCaption"]

  connect() {
    // Remove d-none only from the very first post
    this.postTarget.classList.remove("d-none");
    // Give it a displayed class for easier itteration
    this.postTarget.classList.add("displayed");
    // Don't display the previous arrow
    this.previousTarget.classList.add("d-none");
  }

  previous(event) {
    event.preventDefault();

    const targets = this.postTargets;
    const current_post_index = this.#getIndex();

    targets[current_post_index].classList.add("d-none");
    targets[current_post_index].classList.remove("displayed");

    targets[current_post_index - 1].classList.remove("d-none");
    targets[current_post_index - 1].classList.add("displayed");

    // If we are at the last post and press previous, show the next button again
    if (current_post_index === targets.length - 1) {
      this.nextTarget.classList.remove("d-none");
    }

    // If we are at the second post and press previous, hide the previous button
    if (current_post_index === 1) {
      this.previousTarget.classList.add("d-none");
    }


  }

  next(event) {
    event.preventDefault();

    const targets = this.postTargets;
    const current_post_index = this.#getIndex();

    targets[current_post_index].classList.add("d-none");
    targets[current_post_index].classList.remove("displayed");

    targets[current_post_index + 1].classList.remove("d-none");
    targets[current_post_index + 1].classList.add("displayed");

    this.previousTarget.classList.remove("d-none");

    console.log("Current post:");
    console.log(current_post_index);

    console.log("Targets length:");
    console.log(targets.length - 2);


    if (current_post_index === targets.length - 2) {
      this.nextTarget.classList.add("d-none");
    }

  }

  readMore(event) {
    // Remove the d-none from the current post you're on
    const captions = this.fullCaptionTargets;
    captions[this.#getIndex()].classList.remove("d-none");
  }

  closeCaption(event) {
    console.log("Trying to close caption");
    const captions = this.fullCaptionTargets;
    captions[this.#getIndex()].classList.add("d-none");
    // const captions = this.fullCaptionsTargets;
    // captions[this.#getIndex()].classList.add("d-none");
  }

  #getIndex() {
    const targets = this.postTargets;
    return targets.findIndex(post => post.classList.contains("displayed"))
  }
}
