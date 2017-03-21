import React from "react";
import {connect} from "ripple";
import {inc,dec,set} from "reducer";

@connect
export default class extends React.Component {
  render() {
    const {value, count} = this.props;
    return (
      <div>
        <p><strong>Current Value: {value}</strong></p>
        <p><strong>clicked: {count} times</strong></p>
        <p>
          <button onClick={::this.inc}>+</button>
          <button onClick={::this.dec}>-</button>
          <button onClick={::this.reset}>0</button>
        </p>
      </div>
    );
  }

  inc() {
    this.props.dispatch(inc);
  }

  dec() {
    this.props.dispatch(dec);
  }

  reset() {
    this.props.dispatch(set(0));
  }
}
