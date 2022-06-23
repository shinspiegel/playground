import { parseDiceNotation } from "./parseDiceNotation";

describe("functions/parseDiceNotation", () => {
  test("Should parse a complex dice notation", () => {
    const { amount, bonus, size } = parseDiceNotation("2d10+5");

    expect(amount).toBe(2);
    expect(size).toBe(10);
    expect(bonus).toBe(5);
  });

  test("Should parse a simple dice notation", () => {
    const { amount, bonus, size } = parseDiceNotation("1d6");

    expect(amount).toBe(1);
    expect(size).toBe(6);
    expect(bonus).toBe(0);
  });

  test("Should should throw error if failed to parse a dice", () => {
    expect(() => parseDiceNotation("xrfty")).toThrow();
  });

  test("Should should throw part of the dices failed parse a dice", () => {
    expect(() => parseDiceNotation("xd9+x")).toThrow();
  });

  test("Should not should throw if the bonus is not a number", () => {
    const { amount, bonus, size } = parseDiceNotation("1d6+x");

    expect(amount).toBe(1);
    expect(size).toBe(6);
    expect(bonus).toBe(0);
  });
});
