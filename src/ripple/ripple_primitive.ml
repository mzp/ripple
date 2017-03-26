type ('a, 'b) t = 'b -> ('b -> 'a -> 'b) -> ('a, 'b) Ripple_reducer.t

let make jsonify initial f = {
  Ripple_reducer.jsonify;
  initial;
  f
}

let int x f = make (fun n -> Ripple_json.int n) x f
let number x f = make Ripple_json.number x f
let string x f = make Ripple_json.string x f
