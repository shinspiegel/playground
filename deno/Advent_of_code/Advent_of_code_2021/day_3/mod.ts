const file = Deno.args[0];
if (!file) Deno.exit();
const input = await Deno.readTextFile(file);
const inputData = input
  .split("\n")
  .map((i) => [...i])
  .map((d) => d.map((j) => parseInt(j)));

function getMeasureData(data: number[][]) {
  type Measure = { ones: number; zeros: number };

  const measures: Measure[] = [];

  data.forEach((digits, index) => {
    if (index === 0) {
      digits.forEach(() => measures.push({ ones: 0, zeros: 0 }));
    }

    digits.forEach((digit, position) => {
      if (digit === 0) measures[position].zeros += 1;
      if (digit === 1) measures[position].ones += 1;
    });
  });

  return measures;
}

function calculatePowerConsumption(data: number[][]) {
  const measures = getMeasureData(data);

  const gammaRate: number[] = [];
  const epsilonRate: number[] = [];

  measures.forEach((m) => {
    if (m.ones > m.zeros) {
      gammaRate.push(1);
      epsilonRate.push(0);
    }

    if (m.zeros > m.ones) {
      gammaRate.push(0);
      epsilonRate.push(1);
    }
  });

  const gamaValue = parseInt(gammaRate.join(""), 2);
  const epsilonValue = parseInt(epsilonRate.join(""), 2);

  return gamaValue * epsilonValue;
}

function recursiveOxygen(data: number[][], index = 0): number {
  if (data.length === 0) return 0;

  if (data.length === 1) {
    return parseInt(data[0].join(""), 2);
  }

  const measures = getMeasureData(data);

  let filtered: number[][] = [];

  if (measures[index]?.ones > measures[index]?.zeros) {
    filtered = data.filter((d) => d[index] === 1);
  }

  if (measures[index]?.zeros > measures[index]?.ones) {
    filtered = data.filter((d) => d[index] === 0);
  }

  if (measures[index]?.ones === measures[index]?.zeros) {
    filtered = data.filter((d) => d[index] === 1);
  }

  return recursiveOxygen(filtered, index + 1);
}

function recursiveCo(data: number[][], index = 0): number {
  if (data.length === 0) return 0;

  if (data.length === 1) {
    return parseInt(data[0].join(""), 2);
  }

  const measures = getMeasureData(data);

  let filtered: number[][] = [];

  if (measures[index]?.ones > measures[index]?.zeros) {
    filtered = data.filter((d) => d[index] === 0);
  }

  if (measures[index]?.zeros > measures[index]?.ones) {
    filtered = data.filter((d) => d[index] === 1);
  }

  if (measures[index]?.ones === measures[index]?.zeros) {
    filtered = data.filter((d) => d[index] === 0);
  }

  return recursiveCo(filtered, index + 1);
}

console.log(calculatePowerConsumption(inputData));
console.log(recursiveOxygen(inputData) * recursiveCo(inputData));
