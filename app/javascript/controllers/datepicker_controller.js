import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()
// import { default as rangePlugin } from "flatpickr/dist/plugins/rangePlugin";


export default class extends Controller {

  connect() {
    flatpickr(this.element, {mode: 'range', minDate: "today"})
  }
}
