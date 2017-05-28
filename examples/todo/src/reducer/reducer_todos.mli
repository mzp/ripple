type t = Reducer_todo.t list

val make : unit -> (Action.t, t option) Ripple.Reducer.t
