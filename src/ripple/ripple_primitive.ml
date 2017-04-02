type ('a, 'b) t = 'b -> ('b -> 'a -> 'b) -> ('a, 'b) Ripple_reducer.t

let make jsonify initial f = {
  Ripple_reducer.jsonify;
  initial;
  f
}

let int x f = make (fun n -> Js.Json.number @@ float_of_int n) x f
let bool x f = make (fun n -> Js.Json.boolean @@ if n then Js.true_ else Js.false_) x f
let number x f = make Js.Json.number x f
let string x f = make Js.Json.string x f
let json x f = make (fun x -> x) x f
