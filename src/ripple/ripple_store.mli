type ('a, 'b) t = {
  reducer: 'b -> 'a -> 'b;
  state : 'b;
  jsonify: 'b -> Js.Json.t
}
type js

val dispatch : 'a -> ('a, 'b) t -> ('a, 'b) t
val jsonify : ('a, 'b) t -> Js.Json.t
val value : ('a, 'b) t -> 'b

val to_js: ('a, 'b) t -> js Js.t
