import React from "react";
import {render} from "react-dom";

window.onload = () => {
  const mountNode : Element = document.getElementById("js");

  if (mountNode) {
    render(<p>hello</p>,mountNode);
  }
};
