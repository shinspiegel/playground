import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import { WeaponList } from "./index";
import { store } from "../../stores";

describe("components/WeaponList", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <WeaponList />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
