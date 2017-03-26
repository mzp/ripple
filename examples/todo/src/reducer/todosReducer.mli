type t = TodoReducer.t list

val make : unit -> (Action.t, t) Ripple.Reducer.t
