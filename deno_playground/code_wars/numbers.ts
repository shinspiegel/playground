export class Challenge {
  static solution(number: number) {
    const values: number[] = [];

    for (let i = number - 1; i > 0; i--) {
      if (isMultipleOf(i)) {
        values.push(i);
      }
    }

    return values.reduce((acc, curr) => acc + curr, 0); //change this
  }
}

function isMultipleOf(n: number) {
  if (n % 3 === 0 && n % 5 === 0) return true;
  if (n % 3 === 0) return true;
  if (n % 5 === 0) return true;

  return false;
}

console.log(Challenge.solution(10));
