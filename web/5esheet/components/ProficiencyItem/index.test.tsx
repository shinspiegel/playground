import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { ProficiencyItem } from "./index";

describe("components/ProficiencyItem", () => {
  test("Should render without any props", () => {
    const { container } = render(<ProficiencyItem />);
    expect(container.children.length).not.toBe(0);
  });
});
