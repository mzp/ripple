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
module M = Ripple.Store(struct
  type t = [ `Inc | `Dec ]
end)

(* define reducer *)
let value = M.Primitive.int 0 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1)

(*
  compose object like:
    { "value": 42 }
*)
let store =
  let open M.Object in
  M.Store.create @@ make @@
    ("value", value) @+
    nil
```

Provide store to all components

```js
import React from "react";
import {render} from "react-dom";
import {store} from "reducer";
import App from "./components/App";

window.onload = () => {
  const mountNode = document.getElementById("js");

  render(
    <Provider store={store}>
      <App />
    </Provider>, mountNode);
};
```

And connect components by `@connect`:

```js
import React from "react";
import {connect} from "ripple";
import {inc} from "reducer";

@connect
export default class extends React.Component {
  render() {
    const {value} = this.props;
    return (<div onClick={::this.inc}>{value}</div>)
  }

  inc() {
    this.props.dispatch(inc);
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
