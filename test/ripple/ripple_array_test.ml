open Bs_mocha
open Ripple_store
open Ripple_array

type t = [ `Cons of int | `Tail ]

let store : (t, 'a) Ripple_store.t = make [] Ripple_json.int (fun xs ->
  function
    | `Cons x -> x :: xs
    | `Tail -> List.tl xs)

let () =
  from_pair_suites __FILE__ [
    ("value", fun () ->
      Eq (
        [],
        store |> value));
    ("dispatch", fun () ->
      Eq (
        [1; 2],
        dispatch (`Cons 2) store |> dispatch (`Cons 1) |> value));
    ("jsonify", fun () ->
      Eq (
        Js.Json.parse "[1, 2]",
        dispatch (`Cons 2) store |> dispatch (`Cons 1) |> jsonify ))
  ]
