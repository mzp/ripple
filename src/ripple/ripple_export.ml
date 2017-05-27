type action
type state
external payload: action -> 'a Js.undefined = "payload" [@@bs.get]
external type_: action -> 'a Js.undefined = "type" [@@bs.get]
external of_state: state -> 'a = "%identity"
external to_state: 'a -> state = "%identity"

module type M = sig
  val reducer : state -> action -> state
  val initialState: state
  val jsonify : state -> Js.Json.t
  val bindAction : (action -> unit) -> < dispatch : 'a -> unit > Js.t
  val createAction : 'a -> action
  val taskMiddleware : < dispatch: action -> unit > Js.t -> ((action -> state) -> (action -> state [@bs]) [@bs])
end

let create_action payload : action =
  Obj.magic [%bs.obj { _type="ripple"; payload } ]

let export ?(tasks=[]) base value : (module M) = (
  module struct
    let reducer state action =
      let state' =
        of_state state in
      let action' =
        match Js.Undefined.to_opt (type_ action), Js.Undefined.to_opt (payload action) with
        | Some "ripple", Some payload -> payload
        | Some "@@INIT", _ -> `Init
        | Some x, _ -> failwith (Printf.sprintf "Unknown action: %s" x)
        | _, _ -> failwith "Required field is missing" in
      to_state @@ Ripple_reducer.apply base state' action'

    let initialState =
      to_state value

    let jsonify x =
      Ripple_reducer.jsonify base @@ of_state x

    let bindAction dispatch =
      [%bs.obj { dispatch = (fun x -> dispatch (create_action x)) }]

    let createAction =
      create_action

    let taskMiddleware api =
      let dispatch x =
        api##dispatch @@ create_action x in
      let middleware =
        Ripple_task.Middleware.create tasks dispatch in
      fun [@bs] next -> fun [@bs] action ->
        let result = next action in
        Js.Undefined.iter (payload action) (fun [@bs] x -> middleware x);
        result
  end)
