type t = Todo.t list

val store : unit -> (Action.t, t) Ripple.Store.t
