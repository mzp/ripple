import React from "react";

export default class extends React.Component {
  static displayName = "Provider";

  static propTypes = {
    store: React.PropTypes.any.isRequired,
    dispatch: React.PropTypes.func.isRequired,
    jsonify: React.PropTypes.func.isRequired
  }

  static childContextTypes = {
    store: React.PropTypes.any,
    dispatch: React.PropTypes.func
  }

  getChildContext() {
    return {
      store: this.jsonify(this.store),
      dispatch: this.handleDispatch.bind(this)
    };
  }

  constructor(props, context) {
    super(props, context);
    this.store = props.store;
    this.dispatch = props.dispatch;
    this.jsonify = props.jsonify;
  }

  render() {
    return React.Children.only(this.props.children);
  }

  handleDispatch(action) {
    const next = this.dispatch(action, this.store);
    if(next) { this.store = next }

    // reload
    this.setState({});
  }
}
