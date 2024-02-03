import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDate", "endDate", "totalPrice"];

  connect() {
    this.calculateTotalPrice();
  }

  calculateTotalPrice() {
    const startDate = this.startDateTarget.value;
    const endDate = this.endDateTarget.value;
    if (startDate && endDate) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      const diffTime = Math.abs(end - start);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
      const pricePerDay = parseFloat(this.data.get("price-per-day-value"));
      const totalPrice = pricePerDay * diffDays;
      this.totalPriceTarget.textContent = `Total Price: ¥${parseInt(totalPrice, 10)}`;
      this.totalPriceTarget.style.fontSize = "18px"
    }
  }
}
