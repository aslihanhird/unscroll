import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="save"
export default class extends Controller {

  static targets = ['favouriteForm', 'bookmark']

  connect() {

    const allFavourites = this.favouriteFormTargets;

    console.log(allFavourites);

    const allBookmarks = this.bookmarkTargets;

    console.log(allBookmarks);

  }

  savePost() {
    const allFavourites = this.favouriteFormTargets;

    const allBookmarks = this.bookmarkTargets;

    const index = allFavourites.findIndex(favourite => favourite.classList.contains("displayed"));

    const bookmark = allBookmarks[(index < 0 ? 0 : index)];


    if (bookmark.innerHTML.trim() === `<i class="fa-solid fa-bookmark"></i>`) {
      bookmark.innerHTML = `<i class="fa-regular fa-bookmark"></i>`
    } else {
      bookmark.innerHTML = `<i class="fa-solid fa-bookmark"></i>`;
    }
  }


}
