import { Controller } from "@hotwired/stimulus"
import { useHotkeys } from 'stimulus-use/hotkeys'

// Connects to data-controller="attempt"
export default class extends Controller {
	static targets = [ "hour", "employee", "rateButton", "hourQuantityIndicator", "rateIndicator", "json_output" ];
	rate_options = ['-']
	rate_descriptions = ['']
	backgroundColorsUsed = [
		'bg-gray-100', 'bg-emerald-100', 'bg-lime-100', 'bg-amber-100',
		'bg-gray-200', 'bg-emerald-200', 'bg-lime-200', 'bg-amber-200',
		'bg-gray-300', 'bg-emerald-300', 'bg-lime-300', 'bg-amber-300',
		'bg-gray-400', 'bg-emerald-400', 'bg-lime-400', 'bg-amber-400',
	]
	
	selectedRates = ['-', 'B1', 'B2', 'B3','BP', 'BPS', 'B1m','B2m','B3m','S2','S3','S2m','S3m'];
	selectedRateGroup = 'basic-0';
	
	
	hourSelectQuantity = 1;
	
	connect() {
    useHotkeys(this, {
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
		this.formatHourSelectIndicators();
		this.formatRateSelectIndicators();
	}
	
	
	rate_groups = {
		basic: {
			0: ['-', 'B1', 'B2', 'B3','BP', 'BPS', 'B1m','B2m','B3m','S2','S3','S2m','S3m'],
			1: ['B1'],
			2: ['B2'],
			3: ['B3'],
			4: ['BP'],
			5: ['BPS'],
			6: ['B1m'],
			7: ['B2m'],
			8: ['B3m'],
			9: ['S2'],
			10: ['S3'],
			11: ['S2m'],
			12: ['S3m'],
		},
		extra: {
			0: ['-', 'E1', 'E2', 'E3','E4', 'E5', 'EP','E1m','E2m','E3m','E4m','E5m','EPS'],
			1: ['E1'],
			2: ['E2'],
			3: ['E3'],
			4: ['E4'],
			5: ['E5'],
			6: ['EP'],
			7: ['E1m'],
			8: ['E2m'],
			9: ['E3m'],
			10: ['E4m'],
			11: ['E5m'],
			12: ['EPS'],
		},
		other: {
			0: ['-', 'C1', 'C2', 'C3','C1m','C2m','C3m'],
			1: ['C1'],
			2: ['C2'],
			3: ['C3'],
			4: ['-'],
			5: ['C1m'],
			6: ['C2m'],
			7: ['C3m'],
		},
	};
	
	select_rate_group() {
		this.selectedRateGroup = event.target.id
		var group = event.target.id.match(/^(\w+)-(\d+)$/)[1];
		var number = parseInt(event.target.id.match(/^(\w+)-(\d+)$/)[2]);
		this.selectedRates = this.rate_groups[group][number];
		this.formatRateSelectIndicators();
	}
	
	select_hour_quantity_from_button() {
		const newQuantity = parseInt(event.target.id.match(/^select\-hour\-quantity\-(\d+)$/)[1]);
		this.hourSelectQuantity = newQuantity;
		this.formatHourSelectIndicators();
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
	
	hourClicked() {
		const currentValueMatcher = (element) => element == event.target.textContent;
		var current = this.selectedRates.findIndex(currentValueMatcher)
		var next = current + 1
		if( next >= this.selectedRates.length) {
			next = 0
		}

		const triggeringRow = parseInt(event.target.id.match(/^row\-(\d+)\-hour\-(\d+)$/)[1]);
		const triggeringHour = parseInt(event.target.id.match(/^row\-(\d+)\-hour\-(\d+)$/)[2]);
		
		var offset;

		for( offset = 0; offset < this.hourSelectQuantity; offset++) {
			var targetElement = this.hourTargets.find((element) => element.id == `row-${triggeringRow}-hour-${triggeringHour+offset}`)
			targetElement.textContent = this.selectedRates[next]
		}
		
		this.formatHours();
	}
	

////////////////////////////////////// formatting updaters
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
					color = 'emerald';
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
				case '4': {
					var intensity = 200;
					break;
				}
				case '5': {
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
	
	rate_group_colors = {
		basic: 'emerald',
		extra: 'lime',
		other: 'amber',
	}
	
	formatRateSelectIndicators() {
		this.rateIndicatorTargets.forEach((element) => {
			var group = element.id.match(/^(\w+)-(\d+)$/)[1];
			element.classList.remove(`bg-${this.rate_group_colors[group]}-100`)
			element.classList.remove(`bg-${this.rate_group_colors[group]}-300`)
			if( element.id == this.selectedRateGroup ) {
				element.classList.add(`bg-${this.rate_group_colors[group]}-300`)
			} else {
				element.classList.add(`bg-${this.rate_group_colors[group]}-100`)
			}
		})
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
	


	//////////////// copy shortcuts

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
	
	
	////////////////// utility shortguts from UI
	
	clear_values() {
		this.hourTargets.forEach((element) => {
			element.textContent = "-"
		})
		this.employeeTargets.forEach((element) => element.value = "")
		this.formatHours();
	}
	
	ath_shifts() {
		this.clear_values();
		const shift_hours = [
			'row-0-hour-16',
			'row-0-hour-17',
			'row-0-hour-18',
			'row-0-hour-19',
			'row-0-hour-20',
			'row-0-hour-21',
			'row-0-hour-22',
			'row-0-hour-23',

			'row-1-hour-8',
			'row-1-hour-9',
			'row-1-hour-10',
			'row-1-hour-11',
			'row-1-hour-12',
			'row-1-hour-13',
			'row-1-hour-14',
			'row-1-hour-15',

			'row-2-hour-8',
			'row-2-hour-9',
			'row-2-hour-10',
			'row-2-hour-11',
			'row-2-hour-12',
			'row-2-hour-13',
			'row-2-hour-14',
			'row-2-hour-15',
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

	dgh_shifts() {
		this.clear_values();
		const shift_hours = [
			'row-0-hour-8',
			'row-0-hour-9',
			'row-0-hour-10',
			'row-0-hour-11',
			'row-0-hour-12',
			'row-0-hour-13',
			'row-0-hour-14',
			'row-0-hour-15',

			'row-1-hour-16',
			'row-1-hour-17',
			'row-1-hour-18',
			'row-1-hour-19',
			'row-1-hour-20',
			'row-1-hour-21',
			'row-1-hour-22',
			'row-1-hour-23',

			'row-2-hour-8',
			'row-2-hour-9',
			'row-2-hour-10',
			'row-2-hour-11',
			'row-2-hour-12',
			'row-2-hour-13',
			'row-2-hour-14',
			'row-2-hour-15',

			'row-3-hour-16',
			'row-3-hour-17',
			'row-3-hour-18',
			'row-3-hour-19',
			'row-3-hour-20',
			'row-3-hour-21',
			'row-3-hour-22',
			'row-3-hour-23',

			'row-4-hour-8',
			'row-4-hour-9',
			'row-4-hour-10',
			'row-4-hour-11',
			'row-4-hour-12',
			'row-4-hour-13',
			'row-4-hour-14',
			'row-4-hour-15',
		]
		const shift_elements = this.hourTargets.filter((element) => shift_hours.includes(element.id))
		shift_elements.forEach((element) => {
			element.textContent = 'B1'
		})
		this.employeeTargets.find((element) => element.id == "row-0").value = 9999
		this.employeeTargets.find((element) => element.id == "row-1").value = 462
		this.employeeTargets.find((element) => element.id == "row-2").value = 223
		this.employeeTargets.find((element) => element.id == "row-3").value = 742
		this.employeeTargets.find((element) => element.id == "row-4").value = 1073
		
		this.formatHours();
		
	}
	
	generate_json() {
		var output = new Object();
		
		this.employeeTargets.forEach((element) => {
			const row = parseInt(element.id.match(/^row\-(\d+)$/)[1])
			if( element.value != "" ) {
				output[element.value] = new Object();

				var hour;
				for( hour = 0; hour < 28; hour++) {
					var targetHour;
					targetHour = this.hourTargets.find((element) => element.id == `row-${row}-hour-${hour}`)
					if(targetHour.textContent != '-') {
						output[element.value][hour] = targetHour.textContent
					}
				}
			}
		})


		this.json_outputTarget.value = JSON.stringify(output)
	}
	
	read_json() {
		let object = JSON.parse(this.json_outputTarget.value)
		
		this.clear_values();
		
		for (const [index, [employee, hours]] of Object.entries(Object.entries(object))) {
			let targetEmployee = this.employeeTargets.find((element) => element.id == `row-${index}`)
			targetEmployee.value = employee
			for (const [index2, [hour, value]] of Object.entries(Object.entries(hours))) {
				let targetHour = this.hourTargets.find((element) => element.id == `row-${index}-hour-${hour}`)
				if( targetHour ) {
					targetHour.textContent = value
				}
			}
		}
		
		this.formatHours();
		
	}

}
