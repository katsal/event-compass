import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"];

  connect() {
    this.highlightSelectedCategory();
  }

  highlightSelectedCategory() {
    const urlParams = new URLSearchParams(window.location.search);
    const selectedCategory = urlParams.get("category");

    this.buttonTargets.forEach(button => {
      const categoryName = button.value;
      const isSelected = categoryName === selectedCategory;

      if (isSelected) {
        button.classList.add("selected-category");
      } else {
        button.classList.remove("selected-category");
      }

      button.addEventListener("click", () => {
        if (isSelected) {
          urlParams.delete("category");
        } else {
          urlParams.set("category", categoryName);
        }

        const newUrl = `${window.location.pathname}?${urlParams.toString()}`;
        history.pushState(null, "", newUrl);

        this.highlightSelectedCategory();
      });
    });
  }
}
