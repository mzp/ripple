import React from "react";
import {connect} from "react-redux";
import {jsonify, bindAction, toggle} from "reducer";


@connect(jsonify, bindAction)
export default class extends React.Component {
  render() {
    const { todos } = this.props;
    return (
      <ul>
        { todos.map((todo) =>
            <li key={todo.id}>
              <input type="checkbox" checked={todo.complete} onClick={() => this.handleClick(todo) }/>
              {todo.text}
            </li>)}
      </ul>
    );
  }

  handleClick(todo) {
    this.props.dispatch(toggle(todo.id));
  }
}
