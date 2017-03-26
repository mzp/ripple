val make : 'b list -> ('b -> Js.Json.t) -> ('b list -> 'a -> 'b list) -> ('a, 'b list) Ripple_reducer.t

val lift : ('a, 'b) Ripple_reducer.t -> 'b list -> ('b list -> 'a -> 'b list) -> ('a, 'b list) Ripple_reducer.t
