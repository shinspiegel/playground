import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import { StatItem } from "./index";
import { store } from "../../stores/store";

describe("components/StatItem", () => {
  test("Should render without any props", () => {
    const { container } = render(
      <Provider store={store}>
        <StatItem />
      </Provider>
    );

    expect(container.children.length).not.toBe(0);
  });
});
