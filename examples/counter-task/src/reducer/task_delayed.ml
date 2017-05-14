external set_timeout : ('a -> unit [@bs]) -> int -> unit = "setTimeout"  [@@bs.val]

let delay ms =
  Js.Promise.make (fun ~resolve ~reject:_ -> set_timeout resolve ms)

let run context =
  let open Lwt in
  let open Ripple_task.Context in
  take context
  >>= begin function
    | `DelayedInc ->
      call (delay 1000)
      >>= (fun () -> put context `Inc)
    | _ ->
      Lwt.return ()
  end

let run context = Ripple_task.Task.loop run context
