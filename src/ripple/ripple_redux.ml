type action
type state
external payload: action -> 'a Js.undefined = "payload" [@@bs.get]
external fromState : state -> 'a = "%identity"
external toState : 'a -> state = "%identity"

module type Export = sig
  val reducer : state -> action -> state
  val jsonify : state -> Js.Json.t
  val bindAction : (action -> unit) -> < dispatch : 'a -> unit > Js.t
  val createAction : 'a -> action
  val taskMiddleware : < dispatch: action -> unit > Js.t -> ((action -> state) -> (action -> state [@bs]) [@bs])
end

let create_action payload : action =
  Obj.magic [%bs.obj { _type="ripple"; payload } ]

let to_redux ?(tasks=[]) base : (module Export) = (module struct
    let reducer state action =
      toState @@ match Js.Undefined.to_opt @@ payload action with
      | Some x -> Ripple_reducer.dispatch base (fromState state) x
      | None -> Ripple_reducer.initial base

    let jsonify x =
      Ripple_reducer.jsonify base @@ fromState x

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
