const input = await Deno.readTextFile("day_6/input");
const startingFishes = input.split(",").map((n) => parseInt(n));
const limitDay = 256;

let fishCounter: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0];

startingFishes.forEach((f) => {
  fishCounter[f] += 1;
});

for (let i = 0; i < limitDay; i++) {
  const [zeroIndex, ...updatedFish] = fishCounter;
  updatedFish[8] = 0;

  if (zeroIndex && zeroIndex > 0) {
    updatedFish[6] += zeroIndex;
    updatedFish[8] += zeroIndex;
  }

  fishCounter = updatedFish;
}

const amount = fishCounter.reduce((p, c) => p + c, 0);
console.log(amount);
