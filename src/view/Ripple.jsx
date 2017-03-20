import React from "react";
import {dispatch, jsonify} from "flux";

export default class extends React.Component {
  static childContextTypes = {
    store: React.PropTypes.any,
    dispatch: React.PropTypes.func
  }

  getChildContext() {
    return {
      store: jsonify(this.store),
      dispatch: ::this.dispatch
    };
  }

  constructor(props, context) {
    super(props, context);
    this.store = props.store;
  }

  render() {
    return React.Children.only(this.props.children);
  }

  dispatch(action) {
    this.store = dispatch(this.store, action);

    // reload
    this.setState({});
  }
}
