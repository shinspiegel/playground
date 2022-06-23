import { calculateDamageFor } from "./calculateDamageFor";

describe("functions/calculateDamageFor", () => {
  test("Should generate a basic damage", () => {
    const damage = calculateDamageFor({
      damageDice: "1d6",
      short: "STR",
      stats: [{ name: "Strength", short: "STR", value: 12, mod: 1, weight: 0, isProf: false }],
    });

    expect(damage).toBe("1d6+1");
  });

  test("Should generate a basic negative damage", () => {
    const damage = calculateDamageFor({
      damageDice: "1d6",
      short: "STR",
      stats: [{ name: "Strength", short: "STR", value: 12, mod: -3, weight: 0, isProf: false }],
    });

    expect(damage).toBe("1d6-3");
  });

  test("If not stat is found, should not add anything on the damage", () => {
    const damage = calculateDamageFor({
      damageDice: "1d6",
      short: "STR",
      stats: [{ name: "None", short: "NON", value: 99, mod: 9, weight: 0, isProf: false }],
    });

    expect(damage).toBe("1d6");
  });
});
