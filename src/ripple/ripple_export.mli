type action
type state

module type M = sig
  val reducer : state -> action -> state
  val initialState: state
  val jsonify : state -> Js.Json.t
  val bindAction : (action -> unit)  -> < dispatch : 'a -> unit > Js.t
  val createAction : 'a -> action
  val taskMiddleware : < dispatch: action -> unit > Js.t -> ((action -> state) -> (action -> state [@bs]) [@bs])
end

val create_action : 'a -> action
val export: ?tasks:((([> `Init] as 'a) Ripple_task.t -> unit Lwt.t) list) -> ('a, 'b) Ripple_reducer.t -> 'b -> (module M)
