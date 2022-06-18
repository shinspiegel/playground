import { statToMod } from "./statToMod";

describe("functions/statToMod", () => {
  test("should convert a basic number", () => {
    const mod = statToMod(10);
    expect(mod).toBe(0);
  });

  test("should return -5 if the stat is negative", () => {
    const mod = statToMod(-1);
    expect(mod).toBe(-5);
  });

  test("should convert a positive mod", () => {
    const mod = statToMod(12);
    expect(mod).toBe(1);
  });

  test("should convert a positive odd mod", () => {
    const mod = statToMod(15);
    expect(mod).toBe(2);
  });

  test("should convert a negative mod", () => {
    const mod = statToMod(8);
    expect(mod).toBe(-1);
  });

  test("should convert a negative odd mod", () => {
    const mod = statToMod(7);
    expect(mod).toBe(-2);
  });
});
