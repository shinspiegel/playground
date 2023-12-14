import { render } from "preact";
import { RouterProvider } from "react-router-dom";
import { router } from "./routes";

render(<RouterProvider router={router} />, document.getElementById("app")!);
