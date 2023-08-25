import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attempt"
export default class extends Controller {
	static targets = [ "hour", "employee" ];
	rate_options = ['-']
	rate_descriptions = ['']
	backgroundColorsUsed = ['bg-gray-100', 'bg-teal-100', 'bg-lime-100', 'bg-amber-100']
	
	connect() {
		this.basic_shifts();
	}

	increment() {
		const currentValueMatcher = (element) => element == event.target.textContent;

		var current = this.rate_options.findIndex(currentValueMatcher)
		var next = current + 1

		if( next >= this.rate_options.length) {
			next = 0
		}

		event.target.textContent = this.rate_options[next]
		event.target.title = `New Value For ID ${event.target.id}`
		
		this.formatHours();
	}
	
	use_rates() {
		const targetRates = event.target.id
		
		switch(targetRates) {
			case 'basic': {
				this.rate_options = ['-','B1','B2','B3','BP','BPS','B1m','B2m','B3m'];
				this.rate_descriptions = ['', 'Basic 1x', 'Basic 1.5x', 'Basic 2x', 'Basic Performance', 'Basic Premium Performance', 'Basic 1x Meal Penalty', 'Basic 1.5x Meal Penalty', 'Basic 2x Meal Penalty']
				break;
			}
			case 'extra': {
				this.rate_options = ['-','E1','E2','E3','E4','E5','EP','EPS','E1m','E2m','E3m','E4m','E5m'];
				break;
			}
			case 'other': {
				this.rate_options = ['-','C1','C2','C3','C1m','C2m','C3m','S2','S3','S2m','S3m'];
				break;
			}
		}
		console.log(`switch to ${targetRates} rates`)
	}
	
	formatHours() {
		this.hourTargets.forEach((element) => {
			this.backgroundColorsUsed.forEach((color) => {
				element.classList.remove(color)
			})
			
			switch(element.textContent.slice(0,1)) {
				case '-': {
					element.classList.add('bg-gray-100')
					break;
				}
				case 'B': {
					element.classList.add('bg-teal-100')
					break;
				}
				case 'E': {
					element.classList.add('bg-lime-100')
					break;
				}
				default: {
					element.classList.add('bg-amber-100')
					break;
				}
			}
			
		})
	}
	
	copy_employee_down() {
		const triggeringRow = parseInt(event.target.parentElement.id.match(/^row\-(\d+)$/)[1])

		const myElement = this.employeeTargets.find((element) => element.id == `row-${triggeringRow}`)
		const targetElement = this.employeeTargets.find((element) => element.id == `row-${triggeringRow+1}`)
		targetElement.value = myElement.value
	}

	copy_hours_down() {
		const triggeringRow = parseInt(event.target.parentElement.id.match(/^row\-(\d+)$/)[1])

		// elements to copy
		var myRowString = `row-${triggeringRow}`
		var targetRowString = `row-${triggeringRow+1}`
		
		const hoursToCopy = this.hourTargets.filter((element) => element.id.slice(0,myRowString.length) == myRowString)		
		
		hoursToCopy.forEach((element) => {
			var thisHour = parseInt(element.id.match(/^row\-(\d+)\-hour\-(\d+)$/)[2])

			var sourceElement = this.hourTargets.find((element) => element.id == `${myRowString}-hour-${thisHour}`)
			var targetElement = this.hourTargets.find((element) => element.id == `${targetRowString}-hour-${thisHour}`)
			
			targetElement.textContent = sourceElement.textContent
		})
	}
	
	clear_values() {
		var thing = this.hourTargets.find((element) => element.id )
		this.hourTargets.forEach((element) => {
			element.textContent = "-"
		})
		this.formatHours();
	}
	
	basic_shifts() {
		const shift_hours = [
			'row-0-hour-8',
			'row-0-hour-9',
			'row-0-hour-10',
			'row-0-hour-11',
			'row-0-hour-12',
			'row-0-hour-13',
			'row-0-hour-14',
			'row-0-hour-15',
			'row-1-hour-8',
			'row-1-hour-9',
			'row-1-hour-10',
			'row-1-hour-11',
			'row-1-hour-12',
			'row-1-hour-13',
			'row-1-hour-14',
			'row-1-hour-15',
			'row-2-hour-16',
			'row-2-hour-17',
			'row-2-hour-18',
			'row-2-hour-19',
			'row-2-hour-20',
			'row-2-hour-21',
			'row-2-hour-22',
			'row-2-hour-23',
		]
		const shift_elements = this.hourTargets.filter((element) => shift_hours.includes(element.id))
		shift_elements.forEach((element) => {
			element.textContent = 'B1'
		})
		this.formatHours();
		
	}

}
