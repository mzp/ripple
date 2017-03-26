type ('a, 'b) t = {
  f: 'b -> 'a -> 'b;
  initial : 'b;
  jsonify: 'b -> Js.Json.t
}

val initial : ('a, 'b) t -> 'b
val jsonify : ('a, 'b) t -> 'b -> Js.Json.t
val dispatch : ('a, 'b) t -> 'b -> 'a -> 'b
