import React from "react";
import Form from "./Form";
import List from "./List";

export default class extends React.Component {
  render() {
    return (
      <div>
        <List />
        <Form />
      </div>
    );
  }
}
