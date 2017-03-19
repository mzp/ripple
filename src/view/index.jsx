import React from "react";
import {render} from "react-dom";
import {store} from "flux";
import Ripple from "./Ripple";
import Counter from "./Counter";

window.onload = () => {
  const mountNode : Element = document.getElementById("js");

  if (mountNode) {
    render(
      <Ripple store={store}><Counter msg="counter" /></Ripple>,
      mountNode);
  }
};
