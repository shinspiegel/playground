import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import Home from "../pages/index";
import { store } from "../stores/store";

describe("pages/index", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <Home />
      </Provider>
    );

    expect(container.children.length).not.toBe(0);
  });
});
