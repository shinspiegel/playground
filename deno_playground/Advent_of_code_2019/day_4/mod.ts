function start() {
  let result = 0;

  for (let i = 158126; i <= 624574; i++) {
    if (validator(String(i))) {
      result++;
    }
  }

  console.log("Result: ", result);
}

function validator(password: string) {
  const numbers = password.split("").map((s) => Number(s));

  if (!isIncreaseOnly(numbers)) {
    return false;
  }

  if (!isAdjacent(numbers)) {
    return false;
  }

  return true;
}

function isAdjacent(password: number[]) {
  const noCount: number[] = [];
  let found = false;

  for (let i = 0; i < password.length - 1; i++) {
    if (!noCount.includes(password[i]) && password[i] === password[i + 1]) {
      if (i + 2 < password.length && password[i + 2] === password[i]) {
        noCount.push(password[i]);
      } else {
        found = true;
        break;
      }
    }
  }
  return found;
}

function existsDouble(password: number[]) {
  const doubles: number[] = [];

  for (let i = 0; i < password.length; i++) {
    if (password[i] === password[i + 1]) {
      doubles.push(password[i]);
    }
  }

  if (doubles.length > 0) {
    return true;
  } else {
    return false;
  }
}

function isIncreaseOnly(password: number[]) {
  for (let i = 0; i < password.length; i++) {
    if (password[i] > password[i + 1]) {
      return false;
    }
  }
  return true;
}

start();
