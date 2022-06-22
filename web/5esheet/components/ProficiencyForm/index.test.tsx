import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { ProficiencyForm } from "./index";
import { Provider } from "react-redux";
import { store } from "../../stores/store";

describe("components/ProficiencyForm", () => {
  test("Should render without any props", () => {
    const { container } = render(
      <Provider store={store}>
        <ProficiencyForm />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
