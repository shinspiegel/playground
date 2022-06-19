import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SavesList } from "./index";

describe("components/SavesList", () => {
  test("Should have the list of items", () => {
    const { container } = render(<SavesList />);
    expect(container.children.length).not.toBe(0);
  });
});
