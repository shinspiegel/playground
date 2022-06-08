export function getColumnName() {
  const arg = Deno.args[1];

  if (arg) {
    return arg;
  } else {
    console.warn("The second argument is the column name.");
    return "Column";
  }
}
