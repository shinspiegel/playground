import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { ProficiencyForm } from "./index";

describe("components/ProficiencyForm", () => {
  test("Should render without any props", () => {
    const { container } = render(<ProficiencyForm />);
    expect(container.children.length).not.toBe(0);
  });
});
