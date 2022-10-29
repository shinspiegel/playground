export class EntryColumn {
  private name: string;
  private column: Element;
  private form: HTMLFormElement;
  private list: string[];

  constructor({ draggableClassName: className, name }: { name: string; draggableClassName: string }) {
    this.name = name;
    this.list = [];

    const column = document.querySelector(`.${className}[name=${name}]`);
    const form = document.querySelector(`form[name=${name}]`);

    if (!column) {
      throw new Error("Failed to query element column");
    }

    if (!form) {
      throw new Error("Failed to query form");
    }

    this.form = form as HTMLFormElement;
    this.form.addEventListener("submit", this.onSubmit);
    this.column = column;

    this.loadStorage();

    this.render();
  }

  // Arrow function to bind the 'this'
  onSubmit = (e: SubmitEvent) => {
    e.preventDefault();
    // @ts-ignore
    const element: HTMLInputElement = e.target.elements[0];
    this.list.push(element.value);
    element.value = "";
    this.render();
  };

  update() {
    this.resetList();

    this.column.childNodes.forEach((node) => {
      if (this.isItem(node)) {
        const el = node as HTMLElement;
        this.list.push(el.innerHTML);
      }
    });

    this.render();
  }

  resetList() {
    this.list.length = 0;
  }

  isItem(node: Node): boolean {
    if (node instanceof HTMLElement && node.classList.contains("item")) {
      return true;
    }
    return false;
  }

  saveStorage() {
    localStorage.setItem(`COLUMN_${this.name}`, JSON.stringify(this.list));
  }

  loadStorage() {
    const data = localStorage.getItem(`COLUMN_${this.name}`);

    if (data) {
      const parsed = JSON.parse(data);
      this.list = parsed;
    }
  }

  render() {
    this.column.innerHTML = "";

    this.list.forEach((item) => {
      const el = document.createElement("div");
      el.classList.add("item");
      el.innerHTML = item;
      this.column.appendChild(el);
    });

    this.saveStorage();
  }
}
