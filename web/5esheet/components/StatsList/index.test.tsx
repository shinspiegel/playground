import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import { StatList } from "./index";
import { store } from "../../stores/store";

describe("components/StatList", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <StatList />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
