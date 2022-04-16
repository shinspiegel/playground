const string = "<<<..<......<<<<....>";

const countLeft = [...string].filter((v) => v === "<").length;
const countRight = [...string].filter((v) => v === ">").length;

const result = Math.min(countLeft, countRight);

console.log("Result is:", result);
