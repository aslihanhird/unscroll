import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="save"
export default class extends Controller {

  static targets = ['favourite']

  connect() {
  console.log('connected')
  }

  savePost() {

    const save = this.favouriteTarget
    console.log(save)
    const bookmark = document.getElementById("bookmark")
    console.log(bookmark)
    console.log(bookmark.innerHTML)


    if (bookmark.innerHTML === `<i class="fa-solid fa-bookmark"></i>`) {
      bookmark.innerHTML = `<i class="fa-regular fa-bookmark"></i>`
      console.log("test1")
    } else {
      bookmark.innerHTML = `<i class="fa-solid fa-bookmark"></i>`;
      console.log("test2")
    }
    console.log(bookmark.innerHTML)
  }


}
