import React from "react";
import {connect} from "ripple";
import {add} from "reducer";

@connect
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
    this.props.dispatch(add([this.props.todos, this.input.value]));
    this.input.value = "";
  }
}
