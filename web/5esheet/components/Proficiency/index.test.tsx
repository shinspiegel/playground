import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { ProficiencyBonus } from "./index";

describe("components/ProficiencyBonus", () => {
  test("Should render without any props", () => {
    const { container } = render(<ProficiencyBonus />);
    expect(container.children.length).not.toBe(0);
  });
});
