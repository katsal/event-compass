import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="messages-subscription"
export default class extends Controller {
  static values = { userId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "MessagesChannel", id: this.userIdValue },
      {
        received: data => {
          this.messagesTarget.insertAdjacentHTML("beforeend", data)
        }
      }
    )
    console.log(`Subscribed to the chatroom with the id ${this.userIdValue}.`)

    // console.log(document.body.scrollTop);
    // console.log(document.body.scrollHeight);

    // console.log(this.element.offsetHeight);

    window.scrollTo(0, this.element.offsetHeight);



    // setTimeout(() => {
    //   document.body.scrollTop = document.body.scrollHeight
    // }, 1000);

  }
  resetForm(event) {
    event.target.reset()
  }
}
