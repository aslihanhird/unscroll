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

    console.log(allFavourites);

    const allBookmarks = this.bookmarkTargets;

    console.log(allBookmarks);

    const index_of_displayed_save_form = allFavourites.findIndex(favourite => favourite.classList.contains("displayed"));

    const save = allFavourites[index_of_displayed_save_form];
    const bookmark = allBookmarks[index_of_displayed_save_form];

    if (bookmark.innerHTML.trim() === `<i class="fa-solid fa-bookmark"></i>`) {
      bookmark.innerHTML = `<i class="fa-regular fa-bookmark"></i>`
    } else {
      bookmark.innerHTML = `<i class="fa-solid fa-bookmark"></i>`;
    }
  }


}
