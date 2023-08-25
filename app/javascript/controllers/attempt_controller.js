import { Controller } from "@hotwired/stimulus"
import { useHotkeys } from 'stimulus-use/hotkeys'

// Connects to data-controller="attempt"
export default class extends Controller {
	static targets = [ "hour", "employee", "rateButton", "hourQuantityIndicator" ];
	rate_options = ['-']
	rate_descriptions = ['']
	backgroundColorsUsed = [
		'bg-gray-100', 'bg-emerald-100', 'bg-lime-100', 'bg-amber-100',
		'bg-gray-200', 'bg-emerald-200', 'bg-lime-200', 'bg-amber-200',
		'bg-gray-300', 'bg-emerald-300', 'bg-lime-300', 'bg-amber-300',
		'bg-gray-400', 'bg-emerald-400', 'bg-lime-400', 'bg-amber-400',
	]
	
	hourSelectQuantity = 1;
	
	connect() {
    useHotkeys(this, {
      b: [this.select_basic_rates],
      e: [this.select_extra_rates],
      o: [this.select_other_rates],
      c: [this.select_clear_rates],
      1: [this.select_hour_quantity_from_keyboard],
      2: [this.select_hour_quantity_from_keyboard],
      3: [this.select_hour_quantity_from_keyboard],
      4: [this.select_hour_quantity_from_keyboard],
      5: [this.select_hour_quantity_from_keyboard],
      6: [this.select_hour_quantity_from_keyboard],
      7: [this.select_hour_quantity_from_keyboard],
      8: [this.select_hour_quantity_from_keyboard],
      9: [this.select_hour_quantity_from_keyboard],
    })
		this.basic_shifts();
		this.formatHourSelectIndicators();
	}
	
	select_hour_quantity_from_button() {
		const newQuantity = parseInt(event.target.id.match(/^select\-hour\-quantity\-(\d+)$/)[1]);
		this.hourSelectQuantity = newQuantity;
		this.formatHourSelectIndicators();
	}
	
	formatHourSelectIndicators() {
		this.hourQuantityIndicatorTargets.forEach((element) => {
			element.classList.remove('bg-purple-200')
			element.classList.add('bg-purple-100')
		})
		var hourIndicator = this.hourQuantityIndicatorTargets.find((element) => element.id == `select-hour-quantity-${this.hourSelectQuantity}`);
		hourIndicator.classList.remove('bg-purple-100')
		hourIndicator.classList.add('bg-purple-200')		
	}
	
	formatRateSelectIndicators() {
		
	}
	
	select_hour_quantity_from_keyboard(event) {
		const quantity = parseInt(event.key)
		if( quantity < 1 || quantity > 9) {
			this.hourSelectQuantity = 1;
		} else {
			this.hourSelectQuantity = quantity;
		}
		this.formatHourSelectIndicators();
	}
	
	select_basic_rates() {
		this.rate_options = ['-','B1','B2','B3','BP','BPS','B1m','B2m','B3m'];
		this.rate_descriptions = ['', 'Basic 1x', 'Basic 1.5x', 'Basic 2x', 'Basic Performance', 'Basic Premium Performance', 'Basic 1x Meal Penalty', 'Basic 1.5x Meal Penalty', 'Basic 2x Meal Penalty']
	}
	select_extra_rates() {
		this.rate_options = ['-','E1','E2','E3','E4','E5','EP','EPS','E1m','E2m','E3m','E4m','E5m'];
	}
	select_other_rates() {
		this.rate_options = ['-','C1','C2','C3','C1m','C2m','C3m','S2','S3','S2m','S3m'];
	}
	select_clear_rates() {
		this.rate_options = ['-'];
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
	
	hourClicked() {
		const currentValueMatcher = (element) => element == event.target.textContent;
		var current = this.rate_options.findIndex(currentValueMatcher)
		var next = current + 1
		if( next >= this.rate_options.length) {
			next = 0
		}

		const triggeringRow = parseInt(event.target.id.match(/^row\-(\d+)\-hour\-(\d+)$/)[1]);
		const triggeringHour = parseInt(event.target.id.match(/^row\-(\d+)\-hour\-(\d+)$/)[2]);
		
		var offset;

		for( offset = 0; offset < this.hourSelectQuantity; offset++) {
			var targetElement = this.hourTargets.find((element) => element.id == `row-${triggeringRow}-hour-${triggeringHour+offset}`)
			targetElement.textContent = this.rate_options[next]
		}
		
		this.formatHours();
	}
	
	formatHours() {
		this.hourTargets.forEach((element) => {
			this.backgroundColorsUsed.forEach((color) => {
				element.classList.remove(color)
			})
			
			var color = "gray"
			var intensity = 100
			
			switch(element.textContent.slice(0,1)) {
				case 'B': {
					color = 'emerald';
					break;
				}
				case 'E': {
					color = 'lime';
					break;
				}
				case 'C': {
					color = 'amber';
					break;
				}
				case 'S': {
					color = 'amber';
					break;
				}
			}
			switch(element.textContent.slice(1,2)) {
				case '1': {
					var intensity = 100;
					break;
				}
				case '2': {
					var intensity = 200;
					break;
				}
				case '3': {
					var intensity = 300;
					break;
				}
				case 'P': {
					var intensity = 400;
					break;
				}
			}
			element.classList.add(`bg-${color}-${intensity}`)
			
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
		this.formatHours();
	}
	
	clear_values() {
		this.hourTargets.forEach((element) => {
			element.textContent = "-"
		})
		this.employeeTargets.forEach((element) => element.value = "")
		this.formatHours();
	}
	
	basic_shifts() {
		const shift_hours = [
			'row-2-hour-8',
			'row-2-hour-9',
			'row-2-hour-10',
			'row-2-hour-11',
			'row-2-hour-12',
			'row-2-hour-13',
			'row-2-hour-14',
			'row-2-hour-15',
			'row-1-hour-8',
			'row-1-hour-9',
			'row-1-hour-10',
			'row-1-hour-11',
			'row-1-hour-12',
			'row-1-hour-13',
			'row-1-hour-14',
			'row-1-hour-15',
			'row-0-hour-16',
			'row-0-hour-17',
			'row-0-hour-18',
			'row-0-hour-19',
			'row-0-hour-20',
			'row-0-hour-21',
			'row-0-hour-22',
			'row-0-hour-23',
		]
		const shift_elements = this.hourTargets.filter((element) => shift_hours.includes(element.id))
		shift_elements.forEach((element) => {
			element.textContent = 'B1'
		})
		this.employeeTargets.find((element) => element.id == "row-0").value = 1
		this.employeeTargets.find((element) => element.id == "row-1").value = 1486
		this.employeeTargets.find((element) => element.id == "row-2").value = 3
		
		this.formatHours();
		
	}

}
