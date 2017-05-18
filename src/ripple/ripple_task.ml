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
    let signal x =
      Js.Promise.resolve @@ Lwt_condition.signal cond x in
    let () =
      promise
      |> Js.Promise.then_ (fun result -> signal (Result.Ok result))
      |> Js.Promise.catch (fun error -> signal (Result.Error error))
      |> ignore in
    Lwt_condition.wait cond

  let take_if ~f context =
    let open Lwt.Infix in
    take context
    >|= f
    >>= (function
        | Some x -> Lwt_result.return x
        | None  -> Lwt_result.fail ())

  module Infix = struct
    include Lwt.Infix
    let (>?=) = Lwt_result.bind_lwt
  end

  include Infix
end

module Task = struct
  type 'a t = 'a Context.t -> unit Lwt.t

  let create dispatch task =
    let channel =
      Lwt_mvar.create_empty () in
    let () =
      ignore @@ task { Context.dispatch; channel } in
    channel

  let rec loop f x =
    let open Lwt in
    f x >>= (fun _ -> loop f x)

  let ignore f context =
    Lwt.map Pervasives.ignore (f context)
end

module Middleware = struct
  let create tasks dispatch =
    let channels  =
      List.map (Task.create dispatch) tasks in
    fun action ->
      ListLabels.iter channels ~f:(fun channel ->
        ignore @@ Lwt_mvar.put channel action)
end
