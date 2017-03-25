type ('a, 'b) t = 'b -> ('b -> 'a -> 'b) -> ('a, 'b) Ripple_store.t

let store jsonify state reducer = {
  Ripple_store.jsonify;
  state;
  reducer
}

let int x f = store (fun n -> Ripple_json.int n) x f
let number x f = store Ripple_json.number x f
let string x f = store Ripple_json.string x f
