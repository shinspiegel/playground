class App {
    private matrix: number[][] = [];

    constructor(private amount: number) {
        if (this.amount === undefined) {
            throw new Error("Need to add argument");
        }
    }

    start() {
        this.createEmptySquare();
        this.fillSquare();
        this.draw();
    }

    fillSquare(min: number = 0, max: number = this.amount) {
        if (min > max) return;

        for (let i = min; i < max; i++) {
            for (let j = min; j < max; j++) {
                this.matrix[i][j] += 1;
            }
        }

        this.fillSquare(min + 1, max - 1);
    }

    createEmptySquare() {
        for (let i = 0; i < this.amount; i++) {
            this.matrix.push([]);
            for (let j = 0; j < this.amount; j++) {
                this.matrix[i].push(0);
            }
        }
    }

    draw() {
        const line = Array(this.amount).fill("-").join("-");

        console.log(line);
        this.matrix.forEach((c) => console.log(c.join(" ")));
        console.log(line);
    }
}

new App(Number(Deno.args[0])).start();
