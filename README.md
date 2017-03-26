# :ocean: Ripple

[![Codefresh build status]( https://g.codefresh.io/api/badges/build?repoOwner=mzp&repoName=ripple&branch=master&pipelineName=ripple&accountName=mzp&type=cf-1)]( https://g.codefresh.io/repositories/mzp/ripple/builds?filter=trigger:build;branch:master;service:58cf8ee3bfd25a010000e4b3~ripple)

Typed flux framework.

## :gift: Install

```
npm install -g bs-platform
npm install https://github.com/mzp/ripple.git
```

## :star: Usage
Define reducer/action creator at ML-style.

```ocaml
(* define action *)
type t = [
  `Inc
| `Dec ] [@@deriving variants]

(* define reducer *)
let valueReducer () =
  Ripple.Primitive.int 0 begin fun n -> function
    | `Inc -> n + 1
    | `Dec -> n - 1
end

(*
  compose and export object like:
    { "value": 42 }
*)
let reducer () =
  let open Ripple.Object in
  make @@
    ("value" +> valueReducer ()) @+
    nil

(* export reducers for reducx *)
include (val Ripple.Redux.to_redux (reducer ()) : Ripple.Redux.Export)
```

Provide store to all components using [react-redux](https://github.com/reactjs/react-redux):

```js
import React from "react";
import {render} from "react-dom";
import {createStore} from "redux";
import {Provider} from "react-redux";
import {reducer} from "reducer";
import App from "./components/App";

window.onload = () => {
  const mountNode = document.getElementById("js");
  const store = createStore(reducer);

  render(
    <Provider store={store}>
      <App />
    </Provider>, mountNode);
};
```

And connect components by `@connect`:

```js
import React from "react";
import {connect} from "react-redux";
import {jsonify, createAction, inc} from "reducer";

@connect(jsonify)
export default class extends React.Component {
  render() {
    const {value} = this.props;
    return (<div onClick={::this.inc}>{value}</div>)
  }

  inc() {
    this.props.dispatch(createAction(inc));
  }
}
```

See more examples at [examples/](https://github.com/mzp/ripple/tree/master/examples).

## :+1: Commit symbol

|emoji              |mean                                    |
|-------------------|----------------------------------------|
|:wrench:           |improve development environment         |
|:currency_exchange:|improve FFI                             |
|:sparkles:         |add new feature                         |
|:lipstick:         |improve the format/structure of the code|
|:memo:             |improve document                        |
|:gift:             |improve example                         |
|:camel:            |add OCaml library                       |
|:coffee:           |add Javascript library                  |

## :copyright: License
MIT License
