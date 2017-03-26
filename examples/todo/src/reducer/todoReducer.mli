type t

val create : int -> string -> t
val make : unit -> (Action.t, t) Ripple.Reducer.t
