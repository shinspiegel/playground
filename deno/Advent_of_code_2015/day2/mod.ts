async function getInput() {
  const input = await Deno.readTextFile(Deno.cwd() + "/input");
  const data = input.split("\n");
  return data;
}

async function partOne(data: string[], debug = false) {
  let value = 0;

  data.forEach((d) => {
    const [l, w, h] = d.split("x").map((d) => parseInt(d));

    const p1 = 2 * l * w;
    const p2 = 2 * w * h;
    const p3 = 2 * h * l;

    const area = p1 + p2 + p3;
    const ordered = [l, w, h].sort((a, b) => a - b);
    const extra = ordered[0] * ordered[1];
    const total = area + extra;

    value += total;

    if (debug)
      console.log(`DEBUG::`, {
        p1,
        p2,
        p3,
        area,
        ordered,
        extra,
        total,
        value,
      });
  });

  console.log(value);
}

async function partTwo(data: string[], debug = false) {
  let value = 0;

  data.forEach((d) => {
    const [l, w, h] = d.split("x").map((d) => parseInt(d));
    const area = l * w * h;
    const ordered = [l, w, h].sort((a, b) => a - b);
    const ribbon = ordered[0] * 2 + ordered[1] * 2;
    const total = area + ribbon;

    if (debug)
      console.log(`DEBUG::`, {
        ordered,
        area,
        ribbon,
        total,
      });

    value += total;
  });

  console.log(value);
}

// partTwo(["1x1x10"], true);
partTwo(await getInput());
