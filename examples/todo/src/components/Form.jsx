import React from "react";
import {connect} from "react-redux";
import {jsonify, createAction, add} from "reducer";

@connect(jsonify)
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
    this.props.dispatch(createAction(add(this.input.value)));
    this.input.value = "";
  }
}
