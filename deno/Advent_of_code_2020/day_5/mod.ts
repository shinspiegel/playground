const input: string = await Deno.readTextFile("input");
const data: string[] = input.split("\n");

class Ticket {
    public row = 0;
    public column = 0;
    public id = 0;

    private steps: string[];

    constructor(private code: string) {
        this.steps = [...code];
        this.calculate();
    }

    calculateRow(index = 0, min = 0, max = 127) {
        const key = this.steps[index];
        const half = Math.floor((max - min) / 2);

        if (min === max) {
            this.row = min;
            return this;
        }

        if (key === "F") {
            max -= half + 1;
            this.calculateRow(index + 1, min, max);
        }

        if (key === "B") {
            min += half + 1;
            this.calculateRow(index + 1, min, max);
        }
    }

    calculateColumn(index = 7, min = 0, max = 7) {
        const key = this.steps[index];
        const half = Math.floor((max - min) / 2) + 1;

        if (min === max) {
            this.column = min;
            return this;
        }

        if (key === "L") {
            max -= half;
            this.calculateColumn(index + 1, min, max);
        }

        if (key === "R") {
            min += half;
            this.calculateColumn(index + 1, min, max);
        }
    }

    calculateId() {
        this.id = this.row * 8 + this.column;
    }

    calculate() {
        this.calculateRow();
        this.calculateColumn();
        this.calculateId();
    }
}

const result = data.map((v) => new Ticket(v));
let big = 0;

result.forEach((i) => {
    if (big < i.id) {
        big = i.id;
    }
});

console.log(big);

const idsList = result.map((i) => i.id).sort((a, b) => a - b);

idsList.forEach((id) => {
    if (!idsList.includes(id + 1) && idsList.includes(id + 2)) {
        console.log(id + 1);
    }
});
