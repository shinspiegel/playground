import { App } from "./App.jsx";
import { render, screen } from "@testing-library/react";

Deno.test("hello world #1", () => {
  // How to render?
  const { container } = render(<App />);
});
