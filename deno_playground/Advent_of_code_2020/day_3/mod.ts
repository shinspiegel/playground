import ReadData from "../utils/ReadData.ts";

const data = await ReadData.fromFile("input", (v) => [...v]);

class DownSlope {
    constructor(
        private data: string[][] = [],
        private tree: number = 0,
        private empty: number = 0
    ) {}

    go(right: number = 3, down: number = 1) {
        let count = 1;

        for (let i = down; i < data.length; i += down) {
            const element = data[i];

            const position = (right * count) % element.length;
            const step = element[position];

            if (step === ".") {
                this.empty += 1;
            }

            if (step === "#") {
                this.tree += 1;
            }

            count += 1;
        }

        console.log(`Empty ${this.empty}, tree ${this.tree}`);
        return this.tree;
    }
}

const first = new DownSlope(data).go(1, 1);
const second = new DownSlope(data).go(3, 1);
const third = new DownSlope(data).go(5, 1);
const fourth = new DownSlope(data).go(7, 1);
const fifth = new DownSlope(data).go(1, 2);

console.log(first * second * third * fourth * fifth);
