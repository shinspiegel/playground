import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SkillList } from "./index";
import { Provider } from "react-redux";
import { store } from "../../stores/store";

describe("components/SkillList", () => {
  test("Should have the list of items", () => {
    const { container } = render(
      <Provider store={store}>
        <SkillList />
      </Provider>
    );
    expect(container.children.length).not.toBe(0);
  });
});
