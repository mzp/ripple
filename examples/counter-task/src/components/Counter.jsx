import React from "react";
import {connect} from "react-redux";
import {jsonify, bindAction, inc, dec, set, delayedinc} from "reducer";

@connect(jsonify, bindAction)
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
          <button onClick={::this.delayedInc}>delayed</button>
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

  delayedInc() {
    this.props.dispatch(delayedinc);
  }

  reset() {
    this.props.dispatch(set(0));
  }
}
