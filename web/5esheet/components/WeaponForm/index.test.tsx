import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { Provider } from "react-redux";
import { render } from "@testing-library/react";
import { WeaponForm } from "./index";
import { store } from "../../stores";

describe("components/WeaponForm", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <WeaponForm />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
