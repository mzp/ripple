type t

val create : int -> string -> t
val store : unit -> (Action.t, t) Ripple.Store.t
