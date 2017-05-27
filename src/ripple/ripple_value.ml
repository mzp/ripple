type ('a, 'b) t = ('b -> 'a -> 'b) -> ('a, 'b) Ripple_reducer.t

let make jsonify f =
  Ripple_reducer.make f jsonify

let int f = make (fun n -> Js.Json.number @@ float_of_int n) f
let bool f = make (fun n -> Js.Json.boolean @@ if n then Js.true_ else Js.false_) f
let number f = make Js.Json.number f
let string f = make Js.Json.string f
let json f = make (fun x -> x) f
