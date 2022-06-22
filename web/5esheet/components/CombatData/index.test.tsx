import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { CombatData } from "./index";

describe("components/CombatData", () => {
  test("Should have the list of items", () => {
    const { container } = render(<CombatData />);
    expect(container.children.length).not.toBe(0);
  });
});
