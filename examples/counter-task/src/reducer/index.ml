(* export all actions *)
include Action

(* export store *)
let tasks = [ Task_delayed.run ]

let m =
  let (reducer, value) =
    Reducer.make () in
  Ripple.Export.export ~tasks reducer value

include (val m : Ripple.Export.M)
