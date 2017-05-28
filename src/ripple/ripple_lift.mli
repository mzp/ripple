val option : 'b -> ('a, 'b) Ripple_reducer.t -> ('a, 'b option) Ripple_reducer.t

val array : ('a, 'b) Ripple_reducer.t -> ('a, 'b list) Ripple_reducer.t

val object_ : ('a, 'b) Ripple_reducer.t -> ('a, (Js.Dict.key * 'b) list) Ripple_reducer.t
