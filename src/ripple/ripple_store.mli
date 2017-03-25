type ('a, 'b) t = {
  reducer: 'b -> 'a -> 'b;
  state : 'b;
  jsonify: 'b -> Js.Json.t
}

val dispatch : 'a -> ('a, 'b) t -> ('a, 'b) t
val jsonify : ('a, 'b) t -> Js.Json.t
val value : ('a, 'b) t -> 'b

val create : ('a, 'b) t -> < dispatch : 'a -> ('a, 'b) t -> ('a, 'b) t; jsonify : ('a, 'b) t -> Js.Json.t; store : ('a, 'b) t > Js.t
