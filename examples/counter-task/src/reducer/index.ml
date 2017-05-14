(* export all actions *)
include Action

(* export store *)
let tasks = [ Task_delayed.run ]

include (val Ripple.Redux.to_redux ~tasks (Reducer.make ()) : Ripple.Redux.Export)
