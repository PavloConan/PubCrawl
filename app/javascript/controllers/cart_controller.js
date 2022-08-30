import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  async addItem(e) {
    console.log(e.target.attributes["value"].value);
    var itemId = e.target.attributes["value"].value;

    const response = await fetch(
      "/cart", {
        method: "PATCH",
        mode: 'same-origin',
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
          "Content-Type": 'application/json'
        },
        body: JSON.stringify({ item_id: itemId})
      }
    )
  }

  async clearCart() {
    const response = await fetch(
      "/cart", {
        method: "DELETE",
        mode: 'same-origin',
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
          "Content-Type": 'application/json'
        }
      }
    )
  }
}

