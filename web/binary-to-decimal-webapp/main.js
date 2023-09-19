const binInput = document.getElementById("bin");
const decInput = document.getElementById("dec");

binInput.addEventListener("input", handleBinChange);
decInput.addEventListener("input", handleDecChange);

function handleBinChange(event) {
  binInput.value = removeNonBinary(event.target.value);
  convertToDecimal(binInput.value);
}

function handleDecChange(event) {
  decInput.value = removeNonNumber(event.target.value);
  convertToBinary(decInput.value);
}

function convertToDecimal(bin) {
  const binValue = removeNonBinary(bin);
  binInput.value = binValue;

  const binArray = [...binValue].reverse();
  let result = 0;

  binArray.forEach((value, index) => {
    if (Number(value) === 1) {
      result += Math.pow(2, index);
    }
  });

  decInput.value = result;
}

function convertToBinary(dec) {
  const decValue = removeNonNumber(dec);
  decInput.value = decValue;
  bin.value = Number(decValue).toString(2);
}

function removeNonNumber(string) {
  const stringArray = string.match(/\d/g);
  if (!stringArray || stringArray.length <= 0) return "";
  return stringArray.join("");
}

function removeNonBinary(string) {
  const stringArray = string.match(/[10]/g);
  if (!stringArray || stringArray.length <= 0) return "";
  return stringArray.join("");
}
