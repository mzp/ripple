type ('a, 'b) t

val make : ('a, 'b) t -> ('a, 'b) Ripple_reducer.t

val nil : ('a, unit) t
val (@+) : string * ('a, 'b) Ripple_reducer.t -> ('a, 'c) t -> ('a, 'b * 'c) t
val (+>) : string -> ('a, 'b) Ripple_reducer.t -> string * ('a, 'b) Ripple_reducer.t
