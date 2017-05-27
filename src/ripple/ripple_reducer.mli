type ('a, 'b) t

val apply : ('a, 'b) t -> 'b ->'a -> 'b
val jsonify : ('a, 'b) t -> 'b -> Js.Json.t
val make : ('b -> 'a -> 'b) -> ('b -> Js.Json.t) -> ('a, 'b) t
val map : ('b -> 'a -> 'b) -> ('a, 'b) t -> ('a, 'b) t
