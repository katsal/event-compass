// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="daysrange"
// export default class extends Controller {
//   static targets = ["days", "calendar"]

//   connect() {
//     // console.log(modal);
//     this.inserted = false
//   }
//   showDays(event) {
//     // console.log(event.target);
//     const modal = document.querySelector(".flatpickr-calendar")
//     console.log("hellofirst");
//     if (this.inserted === false ) {
//       console.log(modal);
//       console.log(this.daysTarget);
//       this.daysTarget.classList.remove("d-none")
//       modal.insertAdjacentHTML("afterbegin", this.daysTarget.innerHTML)
//       this.inserted = true
//     }
//     this.daysTarget.remove()
//     // this.daysTarget.classList.toggle("open")
//     // console.log(modal[1]);
//     // modal[1].style.height="550px"
//     // modal[1].style.paddingTop="100px"
//     // modal[1].insertAdjacentHTML("afterbegin", this.daysTarget.innerHTML)
//     const leftarrows = document.querySelector(".flatpickr-prev-month")
//     leftarrows.style.top="95px"

//     const rightarrows = document.querySelector(".flatpickr-next-month")
//     rightarrows.style.top="95px"

//   }
// }
