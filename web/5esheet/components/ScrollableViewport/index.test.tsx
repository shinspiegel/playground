import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { ScrollableViewport } from "./index";

describe("components/ScrollableViewport", () => {
  test("Should have the list of items", () => {
    const { container } = render(<ScrollableViewport />);
    expect(container.children.length).not.toBe(0);
  });
});
