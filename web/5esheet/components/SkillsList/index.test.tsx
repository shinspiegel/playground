import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SkillList } from "./index";

describe("components/SkillList", () => {
  test("Should have the list of items", () => {
    const { container } = render(<SkillList />);
    expect(container.children.length).not.toBe(0);
  });
});
