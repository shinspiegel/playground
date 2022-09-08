const input = [2, 7, 11, 15];
const target = 9;

function twoSum(numberList: number[], target: number): number[] {
  for (let i = 0; numberList.length - 1; i++) {
    for (let j = 1; j < numberList.length; j++) {
      const numA = numberList[i];
      const numB = numberList[j];

      if (i == j) {
        continue;
      }

      if (numA + numB === target) {
        return [i, j];
      }
    }
  }
}

console.log(twoSum(input, target));
