const input = await Deno.readTextFile("day_7/input");
const initialPosition = input.split(",").map((n) => parseInt(n));

const min = Math.min(...initialPosition);
const max = Math.max(...initialPosition);

const partOne = () => {
  let smallest: number | undefined;

  for (let i = min; i <= max; i++) {
    const fuelCostList = initialPosition.map((v) => Math.abs(v - i));
    const costAmount = fuelCostList.reduce((p, c) => p + c, 0);

    if (!smallest) {
      smallest = costAmount;
    }

    if (costAmount < smallest) {
      smallest = costAmount;
    }
  }

  console.log(smallest);
};

partOne();

const partTwo = () => {
  let smallest: number | undefined;

  for (let i = min; i <= max; i++) {
    const movementDistance = initialPosition.map((v) => Math.abs(v - i));
    const fuelCostList = movementDistance.map((d) => ((1 + d) / 2) * d);
    const costAmount = fuelCostList.reduce((p, c) => p + c, 0);

    if (!smallest) {
      smallest = costAmount;
    }

    if (costAmount < smallest) {
      smallest = costAmount;
    }
  }

  console.log(smallest);
};

partTwo();
