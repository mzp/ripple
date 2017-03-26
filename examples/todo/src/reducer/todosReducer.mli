type t = Todo.t list

val make : unit -> (Action.t, t) Ripple.Reducer.t
