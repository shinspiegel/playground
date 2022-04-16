class Password {
    minRange: number;
    maxRange: number;
    character: string;
    value: string;

    constructor(original: string) {
        const [range, character, value] = original.split(" ");

        this.minRange = Number(range.split("-")[0]);
        this.maxRange = Number(range.split("-")[1]);
        this.character = character.replace(/:/, "");
        this.value = value;
    }

    validate() {
        const value = [...this.value];
        const count = value.filter((i) => i === this.character).length;

        if (count >= this.minRange && count <= this.maxRange) {
            return true;
        }
        return false;
    }

    validate_extra() {
        const value = [...this.value];
        const count = value.filter((i) => i === this.character).length;
        const position1 = value[this.minRange - 1];
        const position2 = value[this.maxRange - 1];

        if (position1 === this.character && position2 === this.character) {
            return false;
        }

        if (position1 === this.character || position2 === this.character) {
            return true;
        }

        return false;
    }
}

const input = await Deno.readTextFile("input_big.txt");
const data = input.split("\n").map((i) => new Password(i));

let validPass = 0;
let validExtra = 0;

data.forEach((p) => {
    if (p.validate()) {
        validPass += 1;
    }
    if (p.validate_extra()) {
        validExtra += 1;
    }
});

console.log(validPass, validExtra);
