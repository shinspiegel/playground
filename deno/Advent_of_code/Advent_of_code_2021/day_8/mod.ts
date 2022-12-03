const input = await Deno.readTextFile("day_8/input");
const rawLines = input.split("\n");
const data = rawLines.map((l) => ({
  left: l.split(" | ")[0].trim().split(" "),
  right: l.split(" | ")[1].trim().split(" "),
}));

type Decoder = {
  zero: string;
  one: string;
  two: string;
  three: string;
  four: string;
  five: string;
  six: string;
  seven: string;
  eight: string;
  nine: string;
};

const partOne = () => {
  let count = 0;

  data.forEach(({ right }) => {
    right.forEach((d) => {
      if (d.length === 2) count++;
      if (d.length === 3) count++;
      if (d.length === 4) count++;
      if (d.length === 7) count++;
    });
  });

  console.log(count);
};

partOne();

function filterListBy(list: string[], amount: number) {
  return list.filter((c) => c.length === amount);
}

function removeLetterFromString(original: string, remove: string) {
  [...remove].forEach((l) => {
    original = original.replaceAll(l, "");
  });

  return original;
}

function filterListByList(list: string[], removeList: string[]) {
  removeList.forEach((l) => {
    list = list.filter((i) => i !== l);
  });

  return list;
}

function findCodeByLength(list: string[], length: number): string {
  return filterListBy(list, length)[0];
}

function findCodeWithFilter(
  list: string[],
  codes: string[],
  code: string,
  length: number
) {
  const reducedList = filterListByList(list, codes);

  return reducedList[
    reducedList
      .map((v) => removeLetterFromString(v, code))
      .findIndex((v) => v.length === length)
  ];
}

function decodeLine(line: { left: string[]; right: string[] }): Decoder {
  const fullList = [
    ...new Set(
      [...line.left, ...line.right].map((f) => [...f].sort().join("")).sort()
    ),
  ];

  const one = findCodeByLength(fullList, 2);
  const four = findCodeByLength(fullList, 4);
  const seven = findCodeByLength(fullList, 3);
  const eight = findCodeByLength(fullList, 7);
  const three = findCodeWithFilter(fullList, [one, four, seven, eight], one, 3);

  const six = findCodeWithFilter(
    fullList,
    [one, three, four, seven, eight],
    seven,
    4
  );

  const zero = findCodeWithFilter(
    fullList,
    [one, three, four, seven, eight, six],
    three,
    2
  );

  const two = findCodeWithFilter(
    fullList,
    [one, three, four, seven, eight, six, zero],
    four,
    3
  );

  const nine = findCodeWithFilter(
    fullList,
    [one, three, four, seven, eight, six, zero, two],
    six,
    1
  );

  const five = filterListByList(fullList, [
    zero,
    one,
    two,
    three,
    four,
    six,
    seven,
    eight,
    nine,
  ])[0];

  return {
    zero,
    one,
    two,
    three,
    four,
    five,
    six,
    seven,
    eight,
    nine,
  };
}

const partTwo = () => {
  let value = 0;

  data.forEach((line) => {
    const decoded = decodeLine(line);
    const result = calculateOutput(line.right, decoded);
    value += result;
  });

  console.log(value);
};

function calculateOutput(output: string[], decoder: Decoder) {
  const sorted = output.map((l) => [...l].sort().join(""));
  const numbers = sorted.map((l) => {
    if (l === decoder.zero) return 0;
    if (l === decoder.one) return 1;
    if (l === decoder.two) return 2;
    if (l === decoder.three) return 3;
    if (l === decoder.four) return 4;
    if (l === decoder.five) return 5;
    if (l === decoder.six) return 6;
    if (l === decoder.seven) return 7;
    if (l === decoder.eight) return 8;
    if (l === decoder.nine) return 9;
  });

  return parseInt(numbers.join(""));
}

partTwo();
