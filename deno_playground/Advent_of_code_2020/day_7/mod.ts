const input: string = await Deno.readTextFile("sample");
const data: string[] = input.split("\n");

type BagDict = Record<string, Record<string, unknown>>;

function start(data: string[]) {
  const bags = createBag(data);

  console.log(bags);
}

function createBag(data: string[]) {
  const bags: BagDict = {};

  data.forEach((line) => {
    const key = getBagNameFromValue(line);
    const value = getContainFromValue(line)
      .map(createWeightBag)
      .filter(Boolean);

    bags[key] = {};

    value.forEach((object) => {
      for (const innerKey in object) {
        bags[key][innerKey] = object[innerKey];
      }
    });
  });

  return bags;
}

function createWeightBag(value: string) {
  if (value === "no other") return;
  const bagResult: Record<string, unknown> = {};

  const spliced = value.split(" ");
  const weight = Number(spliced.shift());
  const key = spliced.join(" ");

  bagResult[key] = weight;

  return bagResult;
}

function getBagNameFromValue(value: string) {
  return `${value.split(" ")[0]} ${value.split(" ")[1]}`.trim();
}

function getContainFromValue(value: string) {
  return value
    .replaceAll("bags", "")
    .replaceAll("bag", "")
    .replaceAll(".", "")
    .split("contain")[1]
    .trim()
    .split(",")
    .map((s) => s.trim());
}

console.log(start(data));
