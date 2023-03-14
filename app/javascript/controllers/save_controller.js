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
  }
}
