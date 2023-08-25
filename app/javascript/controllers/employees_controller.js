import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="employees"
export default class extends Controller {
  connect() {
  }
	
	filter_status_update() {
    this.element.submit();
	}
}
