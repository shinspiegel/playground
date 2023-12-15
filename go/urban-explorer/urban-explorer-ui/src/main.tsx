import { render } from "preact";
import { RouterProvider } from "react-router-dom";
import { router } from "./routes";
import { Provider } from "react-redux";
import { appStore } from "./redux/store";

render(
	<Provider store={appStore}>
		<RouterProvider router={router} />
	</Provider>,
	document.getElementById("app")!
);
