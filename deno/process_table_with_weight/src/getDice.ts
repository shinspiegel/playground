export function getDice() {
  const arg = Deno.args[2];

  if (arg) {
    return parseInt(arg);
  } else {
    console.warn("The third argument is the dice. E.g.: '1d100'");
    return 6;
  }
}
