import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {

  static targets = ["mainDiv", "optionsDiv"];

  connect() {

  }

  fade(event) {

    console.log("clicked");

    const mainDiv = this.mainDivTarget;
    const optionsDiv = this.optionsDivTarget;

    console.log(mainDiv);
    console.log(optionsDiv);

    if (mainDiv.classList.contains('animation-hide')) {
      mainDiv.classList.remove('animation-hide');
      optionsDiv.classList.add('animation-hide');
      console.log("executing")
    } else {
      mainDiv.classList.add('animation-hide');
      optionsDiv.classList.remove('animation-hide');
      console.log("executing2");
    }

  }

}
