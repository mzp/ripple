type action
type state
external payload: action -> 'a Js.undefined = "payload" [@@bs.get]
external fromState : state -> 'a = "%identity"
external toState : 'a -> state = "%identity"

module type Export = sig
  val reducer : state -> action -> state
  val jsonify : state -> Js.Json.t
  val createAction : 'a -> action
end

let create_action payload : action =
  Obj.magic [%bs.obj { _type="ripple"; payload } ]

let to_redux base : (module Export) = (module struct
    let reducer state action =
      toState @@ match Js.Undefined.to_opt @@ payload action with
      | Some x -> Ripple_reducer.dispatch base (fromState state) x
      | None -> Ripple_reducer.initial base

    let jsonify x =
      Ripple_reducer.jsonify base @@ fromState x

    let createAction =
      create_action
  end)
