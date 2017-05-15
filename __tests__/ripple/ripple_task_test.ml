open Jest
open Expect

(* action definition *)
type action =
    Ping
  | Pong

(* task definition *)
let ping context =
  let open Ripple_task.Context in
  take_if context ~f:(
    function | Ping -> Some ()
             | _ -> None)
  >?= (fun () ->
      put context Pong)

(* simulate redux middleware *)
let last_action : action option ref =
  ref None

let dispatch action = last_action := Some action

let middleware : action -> unit =
  Ripple_task.Middleware.create [
    Ripple_task.Task.loop @@ Ripple_task.Task.ignore ping
  ] dispatch

let _ =
  describe "task" (fun _ ->
      test "ping" (fun _ ->
          let () =
            last_action := None in
          let () =
            middleware Ping in
          expect !last_action |> toEqual (Some Pong));
      test "loop" (fun _ ->
          let () =
            last_action := None in
          let () =
            middleware Ping in
          expect !last_action |> toEqual (Some Pong));
      test "pong" (fun _ ->
          let () =
            last_action := None in
          let () =
            middleware Pong in
          expect !last_action |> toEqual None))
