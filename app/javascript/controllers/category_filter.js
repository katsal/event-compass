import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"];

  connect() {
    this.highlightSelectedCategory();
  }

  highlightSelectedCategory() {
    const selectedCategory = this.data.get("selectedCategory"); // Get the initial value from HTML data attribute

    this.buttonTargets.forEach(button => {
      const categoryName = button.value;

      if (categoryName === selectedCategory) {
        button.classList.add("selected-category");
        console.log("hello");
      } else {
        button.classList.remove("selected-category");
      }
    });
  }
}
