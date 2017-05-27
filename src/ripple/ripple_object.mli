type ('a, 'b) t

val builder : (('a, unit) t -> ('a, 'b) t) -> ('a, 'b) Ripple_reducer.t * 'b

val field : Js.Dict.key -> ('a, 'b option) Ripple_reducer.t -> ('a, 'c) t -> ('a, 'b option * 'c) t
