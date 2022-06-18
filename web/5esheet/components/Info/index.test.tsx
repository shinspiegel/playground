import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { Info } from "./index";

describe("pages/index", () => {
  test("Should render without any props", () => {
    const { container } = render(<Info />);

    expect(container.children.length).not.toBe(0);
  });
});
