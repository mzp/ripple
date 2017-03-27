type action
type state

module type Export = sig
  val reducer : state -> action -> state
  val jsonify : state -> Js.Json.t
  val bindAction : (action -> unit)  -> < dispatch : 'a -> unit > Js.t
  val createAction : 'a -> action
end

val create_action : 'a -> action
val to_redux : ('a, 'b) Ripple_reducer.t -> (module Export)
