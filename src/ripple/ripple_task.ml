module Context = struct
  type 'a t = {
    channel : 'a Lwt_mvar.t;
    dispatch : 'a -> unit
  }

  let take { channel } =
    Lwt_mvar.take channel

  let put { dispatch } x =
    Lwt.return @@ dispatch x

  let call promise =
    let cond =
      Lwt_condition.create () in
    let () =
      Js.Promise.then_ (fun result -> Js.Promise.resolve @@ Lwt_condition.signal cond result) promise
      |> ignore in
    Lwt_condition.wait cond
end

module Task = struct
  type 'a t = 'a Context.t -> unit Lwt.t

  let rec loop f x =
    let open Lwt in
    f x >>= (fun _ -> loop f x)

  let invoke context task =
    ignore @@ task context
end

module Middleware = struct
  let create tasks dispatch =
    let channel =
      Lwt_mvar.create_empty () in
    let context = {
      Context.dispatch; channel
    } in
    let () =
      List.iter (Task.invoke context) tasks in
    fun action ->
      ignore @@ Lwt_mvar.put channel action
end
