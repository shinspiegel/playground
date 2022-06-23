import { calculateHitFor } from "./calculateHitFor";

describe("functions/calculateHitFor", () => {
  test("Should generate a basic hit", () => {
    const hit = calculateHitFor({
      profBonus: 2,
      short: "STR",
      stats: [{ name: "Strength", short: "STR", value: 12, mod: 1, weight: 0, isProf: false }],
      isProf: true,
    });

    expect(hit).toBe("+3");
  });

  test("Should generate a basic negative hit", () => {
    const hit = calculateHitFor({
      profBonus: 2,
      short: "STR",
      stats: [{ name: "Strength", short: "STR", value: 12, mod: -5, weight: 0, isProf: false }],
      isProf: true,
    });

    expect(hit).toBe("-3");
  });
});
