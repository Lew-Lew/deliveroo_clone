import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multi-step-form"
export default class extends Controller {
  static targets = [ "restriction", "humeur" ]

  connect() {
    this.humeurTarget.style.display = "none"
  }

  nextStep(event) {
    event.preventDefault()
    this.restrictionTarget.style.display = "none"
    this.humeurTarget.style.display = "block"
  }

}
