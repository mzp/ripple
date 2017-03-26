type ('a, 'b) t = 'b -> ('b -> 'a -> 'b) -> ('a, 'b) Ripple_reducer.t

val int : ('a, int) t
val bool : ('a, bool) t
val number : ('a, float) t
val string : ('a, string) t
val json : ('a, Js.Json.t) t
val make : ('b -> Js.Json.t) -> ('a, 'b) t
