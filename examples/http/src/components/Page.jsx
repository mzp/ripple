import React from "react";
import {connect} from "react-redux";
import {jsonify, createAction, inc, dec, set} from "reducer";
import {fetch} from "reducer/dispatcher";

@connect(jsonify)
export default class extends React.Component {
  render() {
    const { ready, data } = this.props;
    return (
      <div>
        { ready ? data : "loading...." }
      </div>
    );
  }

  componentWillMount() {
    fetch(this.props.dispatch, "./hello.world")
  }
}
