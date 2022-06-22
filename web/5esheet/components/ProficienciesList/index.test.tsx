import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { ProficienciesList } from "./index";

describe("components/ProficienciesList", () => {
  test("Should render without any props", () => {
    const { container } = render(<ProficienciesList />);
    expect(container.children.length).not.toBe(0);
  });
});
