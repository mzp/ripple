open Bs_mocha
open Ripple_store
open Ripple_array

type t = [ `Cons of int | `Tail ]

let store1 : (t, 'a) Ripple_store.t = make [] Ripple_json.int (fun xs ->
  function
    | `Cons x -> x :: xs
    | `Tail -> List.tl xs)

let store2 () =
  let value () =
   Ripple_primitive.int 0 (fun n ->
        function
        | `Add m -> n + m
        | `Sub m -> n - m) in
  lift (value ()) [0; 1; 2] (fun xs _ -> 0 :: xs)

let () =
  from_pair_suites __FILE__ [
    ("make.value", fun () ->
      Eq (
        [],
        store1 |> value));
    ("make.dispatch", fun () ->
      Eq (
        [1; 2],
        dispatch (`Cons 2) store1 |> dispatch (`Cons 1) |> value));
    ("make.jsonify", fun () ->
      Eq (
        Js.Json.parse "[1, 2]",
        dispatch (`Cons 2) store1 |> dispatch (`Cons 1) |> jsonify ));
    ("lift.value", fun () ->
      Eq (
        [0; 1; 2],
        store2 () |> value));
    ("lift.dispatch", fun () ->
      Eq (
        [1; 1; 2; 3],
        dispatch (`Add 1) (store2 ()) |> value));
    ("lift.jsonify", fun () ->
        Eq (
          Js.Json.parse "[0, 1, 2]",
          jsonify @@ store2 ()))
  ]
