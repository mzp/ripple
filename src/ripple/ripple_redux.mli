type action
type state

module type Export = sig
  val reducer : state -> action -> state
  val jsonify : state -> Js.Json.t
  val createAction : 'a -> action
end

val to_redux : ('a, 'b) Ripple_reducer.t -> (module Export)
