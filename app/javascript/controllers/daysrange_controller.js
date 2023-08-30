import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="daysrange"
export default class extends Controller {
  static targets = ["days", "calendar"]

  connect() {
    console.log(this.daysTarget);
  }
  showDays(event) {
    console.log(event.target);
    this.daysTarget.classList.toggle("open")
    const modal = document.querySelectorAll(".flatpickr-calendar")
    console.log(modal[1]);
    modal[1].style.height="550px"
    modal[1].style.paddingTop="50px"
    const leftarrows = document.querySelector(".flatpickr-prev-month")
    leftarrows.style.top="50px"

  }
}
