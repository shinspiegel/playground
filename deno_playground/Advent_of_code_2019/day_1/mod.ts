const input: string = await Deno.readTextFile("input");
const data: string[] = input.split("\n");
const values = data.map((s) => Number(s));

function showFuel() {
  const result = values.map((v) => Math.floor(v / 3) - 2);
  console.log(
    "Fuel total: ",
    result.reduce((acc, curr) => acc + curr, 0)
  );
}

function calculateFuelByValue(value: number) {
  let result = 0;

  while (value > 0) {
    const calculated = Math.floor(value / 3) - 2;
    value = calculated;

    if (calculated > 0) {
      result += calculated;
    }
  }

  return result;
}

let result = 0;
values.forEach((v) => {
  result += calculateFuelByValue(v);
});

console.log("Result is: ", result);
