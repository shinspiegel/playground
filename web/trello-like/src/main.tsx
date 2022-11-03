import React from "react";
import { Provider } from "react-redux";
import ReactDOM from "react-dom/client";
import { App } from "./components";
import { store } from "./store/store";
import "./main.scss";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>
);
