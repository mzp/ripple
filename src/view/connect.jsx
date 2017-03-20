import React from "react";
import {jsonify} from "flux";

export default (Component) => class extends React.Component {
  static displayName = "connect"

  static get contextTypes() {
    return {
      store: React.PropTypes.any,
      dispatch: React.PropTypes.func
    };
  }

  render () {
    return (<Component dispatch={::this.context.dispatch} {...this.props} {...this.context.store} />);
  }
}
