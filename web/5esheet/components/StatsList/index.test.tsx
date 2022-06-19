import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import { StatList } from "./index";

describe("components/StatList", () => {
  test("Should have the list of items", () => {
    const { container } = render(<StatList />);
    expect(container.children.length).not.toBe(0);
  });
});
