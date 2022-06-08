export function getFilePath() {
  const arg = Deno.args[0];

  if (arg) {
    return arg;
  } else {
    throw new Error("No file specified");
  }
}
