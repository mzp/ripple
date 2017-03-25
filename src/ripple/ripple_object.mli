type ('a, 'b) t

val make : ('a, 'b) t -> ('a, 'b) Ripple_store.t

val nil : ('a, unit) t
val (@+) : string * ('a, 'b) Ripple_store.t -> ('a, 'c) t -> ('a, 'b * 'c) t
