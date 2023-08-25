import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-toggle"
export default class extends Controller {
  static targets = ["photoUpload"]
  connect() {
    console.log("here");
  }

  upload(event){
    console.log("upload");
    event.preventDefault();
    this.photoUploadTarget.classList.toggle("d-none");
  }
}
