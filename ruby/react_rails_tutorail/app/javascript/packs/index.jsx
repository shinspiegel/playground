// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from "react";
import ReactDOM from "react-dom";
import App from "./views/App";
import { BrowserRouter, Switch, Route } from "react-router-dom";

document.addEventListener("DOMContentLoaded", () => {
    ReactDOM.render(
        <BrowserRouter>
            <Switch>
                <Route path="/" component={App} exact/>
                <Route path="*" component={() => <h1>404</h1>} />
            </Switch>
        </BrowserRouter>,
        document.body.appendChild(document.createElement("div"))
    );
});
