import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attempt"
export default class extends Controller {
	static targets = [ "name", "output" ]
	static options = ["-", "1x","1.5x","2x","M-1x","M-1.5x","M-2x"]

  greet() {
		this.outputTarget.textContent = `Hello, ${this.nameTarget.value}`
  }
	
	increment() {
	  const options = ["-", "1x","1.5x","2x","M-1x","M-1.5x","M-2x"]
		const currentValueMatcher = (element) => element == event.target.textContent;
		console.log(`options array is: "${options}"`)
		console.log(`index for current value is: ${options.findIndex(currentValueMatcher)}`)
		var current = options.findIndex(currentValueMatcher)
		var next = current + 1
		console.log(`index for next value is: ${next} ("${options[next]}") out of ${options.length}`)
		if( next >= options.length) {
			next = 0
		}
		console.log(`index for next value is: ${next} ("${options[next]}")`)
		event.target.textContent = options[next]
	}

}
