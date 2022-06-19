import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SaveItem } from "./index";

describe("components/SaveItem", () => {
  test("Should have the list of items", () => {
    const { container } = render(<SaveItem />);
    expect(container.children.length).not.toBe(0);
  });
});
