import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SaveItem } from "./index";
import { Provider } from "react-redux";
import { store } from "../../stores/store";

describe("components/SaveItem", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <SaveItem />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
