(* export all actions *)
include Action

(* export store *)
let m =
  let (reducer, value) =
    Reducer.make () in
  Ripple.Export.export reducer value

include (val m : Ripple.Export.M)
