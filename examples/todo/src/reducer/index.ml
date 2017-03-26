(* expor all actions *)
include Action

(* export store *)
include (val Ripple.Redux.to_redux (Reducer.make ()) : Ripple.Redux.Export)
