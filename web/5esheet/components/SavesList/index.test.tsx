import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SavesList } from "./index";
import { store } from "../../stores/store";
import { Provider } from "react-redux";

describe("components/SavesList", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <SavesList />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
