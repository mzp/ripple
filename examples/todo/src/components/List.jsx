import React from "react";
import {connect} from "react-redux";
import {jsonify, createAction, toggle} from "reducer";


@connect(jsonify)
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
    this.props.dispatch(createAction(toggle(todo.id)));
  }
}
