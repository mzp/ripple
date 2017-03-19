import React from "react";
import connect from "./connect";
import {inc, dec} from "flux";

@connect
export default class extends React.Component {
  render() {
    const { msg, nest: { value, str } } = this.props;
    return (
      <div>
        <div>{msg}: {value}</div>
        <div>last action: {str}</div>
        <div>
          <button onClick={::this.inc}>+</button>
          <button onClick={::this.dec}>-</button>
        </div>
      </div>);
  }

  inc() {
    this.props.dispatch(inc)
  }

  dec() {
    this.props.dispatch(dec)
  }

}
