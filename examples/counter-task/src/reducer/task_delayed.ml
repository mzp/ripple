external set_timeout : ('a -> unit [@bs]) -> int -> unit = "setTimeout"  [@@bs.val]

let delay ms =
  Js.Promise.make (fun ~resolve ~reject:_ -> set_timeout resolve ms)

let run context =
  let open Ripple.Task in
  take_if context ~f:(function `DelayedInc -> Some () | _ -> None)
  >?= (fun () -> call (delay 1000))
  >?= (fun _ -> put context `Inc)

let run context = Ripple.Task.loop (Ripple.Task.make run) context
