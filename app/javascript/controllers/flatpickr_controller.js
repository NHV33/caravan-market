import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
    });
  }
}
