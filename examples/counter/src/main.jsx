import React from "react";
import {render} from "react-dom";
import {Provider} from "ripple";
import {store} from "reducer";
import Counter from "./components/Counter";

window.onload = () => {
  const mountNode = document.getElementById("js");

  if (mountNode) {
    render(
        <Provider store={store}>
          <Counter />
        </Provider>, mountNode);
  }
};
