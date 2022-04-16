function autobind(_target: any, _methodName: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  const adjDescriptor: PropertyDescriptor = {
    configurable: true,
    get() {
      const boundedFunction = originalMethod.bind(this)
      return boundedFunction
    },
  };
  return adjDescriptor;
}

interface iForm {
  input: HTMLInputElement
  description: HTMLInputElement
  people: HTMLInputElement
}

class InputProject {
  template: HTMLTemplateElement
  host: HTMLDivElement
  formElement: HTMLFormElement
  form: iForm

  constructor() {
    this.template = document.getElementById("project-input")! as HTMLTemplateElement
    this.host = document.getElementById("app")! as HTMLDivElement
    this.formElement = document.importNode(this.template.content, true).firstElementChild as HTMLFormElement
    this.formElement.id = "user-input"

    this.form = {} as iForm
    this.form.input = this.formElement.querySelector("#title")! as HTMLInputElement
    this.form.description = this.formElement.querySelector("#description")! as HTMLInputElement
    this.form.people = this.formElement.querySelector("#people")! as HTMLInputElement

    this.configure()
    this.attach()
  }

  private submitHandler(event: Event) {
    event.preventDefault()
    console.log("What?")
  }

  private configure() {
    this.formElement.addEventListener("submit", this.submitHandler.bind(this))
  }

  private attach() {
    const element = this.formElement
    this.host.insertAdjacentElement("afterbegin", element)
  }
}

const project = new InputProject()
