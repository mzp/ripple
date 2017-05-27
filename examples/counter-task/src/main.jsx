import React from "react";
import {createStore, applyMiddleware, compose} from "redux";
import {Provider} from "react-redux";
import {render} from "react-dom";
import {reducer, jsonify, taskMiddleware, tasks, initialState} from "reducer";
import Counter from "./components/Counter";

window.onload = () => {
  const mountNode = document.getElementById("js");

  if (mountNode) {
    const composeEnhancers =
      typeof window === 'object' &&
      window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?
      window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
        stateSanitizer: jsonify
      }) : compose;

    const store = createStore(reducer,
      initialState,
      composeEnhancers(applyMiddleware(taskMiddleware)));

    render(
        <Provider store={store}>
          <Counter />
        </Provider>, mountNode);
  }
};
