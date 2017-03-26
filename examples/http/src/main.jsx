import React from "react";
import {createStore} from "redux";
import {Provider} from "react-redux";
import {render} from "react-dom";
import {reducer, jsonify} from "reducer";
import Counter from "./components/Counter";

window.onload = () => {
  const mountNode = document.getElementById("js");

  if (mountNode) {
    const store = createStore(reducer,
      window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__({
        stateSanitizer: jsonify
      }));

    render(
        <Provider store={store}>
          <Counter />
        </Provider>, mountNode);
  }
};
