type ('a, 'b) t = {
  reducer: 'b -> 'a -> 'b;
  state : 'b;
  jsonify: 'b -> Js.Json.t
}

let dispatch action ({ state; reducer} as store) =
  { store with state = reducer state action }

let jsonify { state; jsonify } =
  jsonify state

let value { state } =
  state

let create store = [%bs.obj {
  store; dispatch; jsonify
}]
