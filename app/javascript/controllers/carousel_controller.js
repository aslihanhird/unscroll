import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["media", "previous", "next"]

  connect() {

    const allMedia = this.mediaTargets

    allMedia.slice(1).forEach((media) => {
      media.classList.add("d-none");
    })

    allMedia[0].classList.add("displayed");

    this.previousTarget.classList.add("d-none");

  }


  previousPost(event) {
    const allMedia = this.mediaTargets;
    const current_item_index = this.#getIndex();

    if (current_item_index == 0) { return }

    allMedia[current_item_index].classList.toggle("displayed");
    allMedia[current_item_index].classList.toggle("d-none");

    allMedia[current_item_index - 1].classList.toggle("displayed");
    allMedia[current_item_index - 1].classList.toggle("d-none");

    this.nextTarget.classList.remove("d-none");

    if (current_item_index == 1) {
      this.previousTarget.classList.add("d-none");
    }


  }

  nextPost(event) {
    const allMedia = this.mediaTargets;
    const current_item_index = this.#getIndex();

    if (current_item_index == allMedia.length - 1) { return }

    allMedia[current_item_index].classList.toggle("displayed");
    allMedia[current_item_index].classList.toggle("d-none");

    allMedia[current_item_index + 1].classList.toggle("displayed");
    allMedia[current_item_index + 1].classList.toggle("d-none");

    this.previousTarget.classList.remove("d-none");

    if (current_item_index == allMedia.length - 2) {
      this.nextTarget.classList.add("d-none");
    }


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

          // If the movement is horizontal, execute this
          // and if the swipe was faster than 300 ms
          if (Math.abs(verticalDifference) < Math.abs(horizontalDifference) && timeDiff < 300) {

            // If the movement is up and the distance is over 400
            if (horizontalDifference > 0 && Math.abs(horizontalDifference) > 200) {
              event.preventDefault();
              // swipe up
              this.nextPost();

              // If the movement is down and the distance is over 400
            } else if (horizontalDifference < 0 && Math.abs(horizontalDifference) > 200) {
              event.preventDefault();
              // swipe down
              this.previousPost();
            }

          }
    });
  }


  #getIndex() {
    const allPosts = this.postTargets;

    return this.mediaTargets.findIndex(media => media.classList.contains("displayed"))
  }
}
