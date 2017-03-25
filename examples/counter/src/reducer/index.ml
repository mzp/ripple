(* export all actions *)
include Action

(* export store *)
let store = Ripple.Store.to_js (Store.store ())
