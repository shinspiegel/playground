import { modToStat } from "./modToStat";

describe("functions/convertStatToMod", () => {
  test("should convert a basic number", () => {
    const mod = modToStat(0);
    expect(mod).toBe(10);
  });

  test("should convert a big negative mod", () => {
    const mod = modToStat(-10);
    expect(mod).toBe(1);
  });

  test("should convert a positive mod", () => {
    const mod = modToStat(1);
    expect(mod).toBe(12);
  });

  test("should convert a negative mod", () => {
    const mod = modToStat(-1);
    expect(mod).toBe(8);
  });
});
