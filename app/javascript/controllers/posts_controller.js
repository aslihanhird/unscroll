import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {

  static targets = ["post", "previous", "next", "fullCaption", "progressBar"]


  connect() {

    const allPosts = this.postTargets;

    // Add d-none to every post but the first
    allPosts.slice(1).forEach((post) => {
      post.classList.add("d-none");
    })

    // Give it a displayed class for easier itteration
    allPosts[0].classList.add("displayed");

    // Don't display the previous arrow
    this.#hidePreviousButton();
    
    // Default progress bar when page loads
    let numberOfPosts = this.postTargets.length;
    let valueProgress = 100 / numberOfPosts;
    let progress = this.progressBarTarget;
    progress.style.width = (valueProgress) + '%';

  }

  previous(event) {
    event.preventDefault();

    const allPosts = this.postTargets;
    const current_post_index = this.#getIndex();

    console.log(allPosts);
    console.log(current_post_index);

    allPosts[current_post_index].classList.add("d-none");
    allPosts[current_post_index].classList.remove("displayed");

    allPosts[current_post_index - 1].classList.remove("d-none");
    allPosts[current_post_index - 1].classList.add("displayed");

    // If we are at the last post and press previous, show the next button again
    if (current_post_index === allPosts.length - 1) {
      this.#showNextButton();
      // this.nextTarget.classList.remove("d-none");
    }

    // If we are at the second post and press previous, hide the previous button
    if (current_post_index === 1) {
      this.#hidePreviousButton();
      // this.previousTarget.classList.add("d-none");
    }

    // Progress bar
    let numberOfPosts = this.postTargets.length;
    let valueProgress = 100 / numberOfPosts;
    let decreaseValue = valueProgress * (current_post_index+1);
    let progress = this.progressBarTarget;

    if (current_post_index === 0) {
      progress.style.width = (decreaseValue-valueProgress) + '%';
    }
    progress.style.width = (decreaseValue-valueProgress) + '%';

  }

  next(event) {
    event.preventDefault();

    const allPosts = this.postTargets;
    const current_post_index = this.#getIndex();

    allPosts[current_post_index].classList.add("d-none");
    allPosts[current_post_index].classList.remove("displayed");


    allPosts[current_post_index + 1].classList.remove("d-none");
    allPosts[current_post_index + 1].classList.add("displayed");

    this.#showPreviousButton();

    if (current_post_index === allPosts.length - 2) {
      this.#hideNextButton();
    }

    // Progress bar
    let numberOfPosts = this.postTargets.length;
    let valueProgress = 100 / numberOfPosts;
    let increaseValue = valueProgress * (current_post_index+1);
    console.log(increaseValue*2);
    let progress = this.progressBarTarget;

    if (current_post_index === 0) {
      progress.style.width = (increaseValue + valueProgress) + '%';
    }
    progress.style.width = (increaseValue + valueProgress) + '%';

    // Change the color of the progress bar when list is read
    if (increaseValue + valueProgress === 100) {
      progress.style.backgroundColor = "#B5F1CC"
    }

  }

  readMore(event) {
    // Remove the d-none from the current post you're on
    const captions = this.fullCaptionTargets;

    captions[this.#getIndex()].classList.remove("d-none");
  }

  closeCaption(event) {
    const captions = this.fullCaptionTargets;

    captions[this.#getIndex()].classList.add("d-none");
  }

  #getIndex() {
    const allPosts = this.postTargets;

    return allPosts.findIndex(post => post.classList.contains("displayed"))
  }

  #hidePreviousButton() {
    this.previousTarget.style.opacity = 0;
  }

  #showPreviousButton() {
    this.previousTarget.style.opacity = 1;
  }

  #hideNextButton() {
    this.nextTarget.style.opacity = 0;
  }

  #showNextButton() {
    this.nextTarget.style.opacity = 1;
  }
}
