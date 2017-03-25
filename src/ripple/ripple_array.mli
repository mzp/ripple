val make : 'b list -> ('b -> Js.Json.t) -> ('b list -> 'a -> 'b list) -> ('a, 'b list) Ripple_store.t

val lift : ('a, 'b) Ripple_store.t -> 'b list -> ('b list -> 'a -> 'b list) -> ('a, 'b list) Ripple_store.t
