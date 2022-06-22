import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { CombatData } from "./index";
import { Provider } from "react-redux";
import { store } from "../../stores/store";

describe("components/CombatData", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <CombatData />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
