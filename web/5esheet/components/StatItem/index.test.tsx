import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import { StatItem } from "./index";

describe("components/StatItem", () => {
  test("Should render without any props", () => {
    const { container } = render(<StatItem />);

    expect(container.children.length).not.toBe(0);
  });
});
