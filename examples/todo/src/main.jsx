import React from "react";
import {render} from "react-dom";
import {Provider} from "ripple";
import {store} from "reducer";
import App from "./components/App";

window.onload = () => {
  const mountNode = document.getElementById("js");

  if (mountNode) {
    render(
        <Provider store={store}>
          <App />
        </Provider>, mountNode);
  }
};
