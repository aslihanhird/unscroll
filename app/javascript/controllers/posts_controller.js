import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {

  static targets = ["post", "previous", "next", "fullCaption", "progressBar", "close", "favourite"];

  connect() {

    const allPosts = this.postTargets;
    const allFavourites = this.favouriteTargets;


    // Add d-none to every post but the first
    allPosts.slice(1).forEach((post) => {
      post.classList.add("d-none");
    })

    // Give it a displayed class for easier itteration
    allPosts[0].classList.add("displayed");
    // Give displayed to the first favourite form
    allFavourites[0].classList.add("displayed");

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

    this.#showPreviousPost();

  }

  next(event) {
    event.preventDefault();

    this.#showNextPost();

  }

  readMore(event) {
    // Remove the d-none from the current post you're on
    const captions = this.fullCaptionTargets;

    captions[this.#getIndex()].classList.remove("d-none");

    this.closeTarget.classList.add("d-none");
  }

  closeCaption(event) {
    const captions = this.fullCaptionTargets;

    captions[this.#getIndex()].classList.add("d-none");

    this.closeTarget.classList.remove("d-none");

  }

  swipe(event) {

    // Define swipe event intial position
    const startX = event.changedTouches[0].clientX;
    const startY = event.changedTouches[0].clientY;
    const startTime = event.timeStamp;

    document.addEventListener("touchend", (eventEnd) => {

      // Define swipe event end position
      const endX = eventEnd.changedTouches[0].clientX;
      const endY = eventEnd.changedTouches[0].clientY;
      const endTime = eventEnd.timeStamp;
      const timeDiff = endTime - startTime;

      // Calculate movement
      const verticalDifference = startY - endY;
      const horizontalDifference = startX - endX;

      // If the movement is vertical, execute this
      // and if the swipe was faster than 300 ms
      if (Math.abs(verticalDifference) > Math.abs(horizontalDifference) && timeDiff < 300) {

        // If the movement is up and the distance is over 400
        if (verticalDifference > 0 && Math.abs(verticalDifference) > 400) {
          event.preventDefault();
          // swipe up
          this.#showNextPost();
          // If the movement is down and the distance is over 400
        } else if (verticalDifference < 0 && Math.abs(verticalDifference) > 400) {
          event.preventDefault();
          // swipe down
          this.#showPreviousPost();
        }

      }
    });

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

  #showNextPost() {
    const allPosts = this.postTargets;
    const allFavourites = this.favouriteTargets;
    const current_post_index = this.#getIndex();

    // If we're at the last post, stop here.
    if (current_post_index == allPosts.length - 1) {
      return
    }

    allPosts[current_post_index].classList.add("d-none");
    allPosts[current_post_index].classList.remove("displayed");

    allPosts[current_post_index + 1].classList.remove("d-none");
    allPosts[current_post_index + 1].classList.add("displayed");

    allFavourites[current_post_index].classList.remove("displayed");
    allFavourites[current_post_index + 1].classList.add("displayed");

    this.#showPreviousButton();

    if (current_post_index === allPosts.length - 2) {
      this.#hideNextButton();
    }

    // Progress bar
    this.#updateProgressBar(current_post_index);



  }

  #showPreviousPost() {
    const allPosts = this.postTargets;
    const allFavourites = this.favouriteTargets;

    const current_post_index = this.#getIndex();

    // If we're at the first post, stop here.
    if (current_post_index == 0) {
      return
    }

    allPosts[current_post_index].classList.add("d-none");
    allPosts[current_post_index].classList.remove("displayed");

    allPosts[current_post_index - 1].classList.remove("d-none");
    allPosts[current_post_index - 1].classList.add("displayed");

    allFavourites[current_post_index].classList.remove("displayed");
    allFavourites[current_post_index - 1].classList.add("displayed");

    // If we are at the last post and press previous, show the next button again
    if (current_post_index === allPosts.length - 1) {
      this.#showNextButton();
    }

    // If we are at the second post and press previous, hide the previous button
    if (current_post_index === 1) {
      this.#hidePreviousButton();
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

  #updateProgressBar(current_post_index) {

    let numberOfPosts = this.postTargets.length;
    let valueProgress = 100 / numberOfPosts;
    let increaseValue = valueProgress * (current_post_index+1);
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
}
