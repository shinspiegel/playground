import "@testing-library/jest-dom/extend-expect";
import "@testing-library/jest-dom";
import { render } from "@testing-library/react";
import { SkillItem } from "./index";

describe("components/SkillItem", () => {
  test("Should have the list of items", () => {
    const { container } = render(<SkillItem />);
    expect(container.children.length).not.toBe(0);
  });
});
