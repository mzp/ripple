import React from "react";
import {connect} from "react-redux";
import {jsonify, bindAction} from "reducer";
import {fetch} from "reducer/dispatcher";

@connect(jsonify, bindAction)
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
