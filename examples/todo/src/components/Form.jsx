import React from "react";
import {connect} from "react-redux";
import {jsonify, bindAction, add} from "reducer";

@connect(jsonify, bindAction)
export default class extends React.Component {
  render() {
    return (
      <div>
        <input type="text" ref={(input) => this.input = input} />
        <button onClick={::this.add}>+</button>
      </div>
    );
  }

  add() {
    this.props.dispatch(add(this.input.value));
    this.input.value = "";
  }
}
