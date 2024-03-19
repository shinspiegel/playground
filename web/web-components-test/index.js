console.log("Web Components 2024 state");

const PROPERTY = "color"

class MyCustomElement extends HTMLElement {
	static observedAttributes = [PROPERTY];

	constructor() {
		super();
		this.textContent = this.getAttribute(PROPERTY)
	}

	connectedCallback() {
		console.log("Custom element added to page.");
	}

	disconnectedCallback() {
		console.log("Custom element removed from page.");
	}

	adoptedCallback() {
		console.log("Custom element moved to new page.");
	}

	attributeChangedCallback(_name, _oldValue, newValue) {
		// If there is a whole bunch of properties needs to check before using it
		this.textContent = newValue
	}
}

[...document.getElementsByTagName("my-custom-element")].forEach((el) => {
	setInterval(() => {
		el.setAttribute(PROPERTY, parseInt(el.getAttribute(PROPERTY)) + 1)
	}, 1000);
});

customElements.define("my-custom-element", MyCustomElement);
