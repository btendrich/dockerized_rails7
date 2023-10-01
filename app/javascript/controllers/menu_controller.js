import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["ratesDropdown", "ratesButton", "employeesMenuDropdown", "employeesMenuButton", "payrollDropdown", "payrollButton"];

  connect() {
  }

  toggleRates() {
    this.ratesDropdownTarget.classList.toggle("hidden")
  }	
	hideRates() {
    if (!this.ratesButtonTarget.contains(event.target)) {
			this.ratesDropdownTarget.classList.add("hidden")
    }
	}

  toggleEmployeesMenu() {
    this.employeesMenuDropdownTarget.classList.toggle("hidden")
  }	
	hideEmployeesMenu() {
    if (!this.employeesMenuButtonTarget.contains(event.target)) {
			this.employeesMenuDropdownTarget.classList.add("hidden")
    }
	}

  togglePayrollMenu() {
    this.payrollDropdownTarget.classList.toggle("hidden")
  }	
	hidePayrollMenu() {
    if (!this.payrollButtonTarget.contains(event.target)) {
			this.payrollDropdownTarget.classList.add("hidden")
    }
	}

}