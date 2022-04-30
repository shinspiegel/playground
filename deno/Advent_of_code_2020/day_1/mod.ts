const input = await Deno.readTextFile("input.txt");
const data = input.split("\n").map((i) => Number(i));

// console.log(data)

// const data = [1721, 979, 366, 299, 675, 1456];

let result = 0;

for (let i = 0; i < data.length; i++) {
    const outer = data[i];

    for (let j = 0; j < data.length; j++) {
        const middle = data[j];

        for (let k = 0; k < data.length; k++) {
            const inner = data[k];

            if (outer + middle + inner === 2020) {
                result = outer * middle * inner;
            }
        }
    }
}

console.log(result);
