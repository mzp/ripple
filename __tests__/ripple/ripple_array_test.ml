open Jest
open Expect
open Ripple_reducer
open Ripple_array

type t = [ `Cons of int | `Tail ]

let reducer1 : (t, 'a) Ripple_reducer.t =
  make [] Ripple_json.int (fun xs -> function
    | `Cons x -> x :: xs
    | `Tail -> List.tl xs)

let reducer2 : ([`Add of int | `Sub of int], 'a) Ripple_reducer.t =
  let value () =
   Ripple_primitive.int 0 (fun n ->
        function
        | `Add m -> n + m
        | `Sub m -> n - m) in
  lift (value ()) [0; 1; 2] (fun xs _ -> 0 :: xs)

let _ =
  describe "make" (fun _ ->
      test "initial" (fun _ ->
          expect (initial reducer1) |> toEqual []);
      test "dispatch" (fun _ ->
          expect (dispatch reducer1 [] (`Cons 1)) |> toEqual [1]);
      test "jsonify" (fun _ ->
          expect (jsonify reducer1 [1]) |> toEqual (Js.Json.parse "[1]")));
  describe "lift" (fun _ ->
      test "initial" (fun _ ->
          expect (initial reducer2) |> toEqual [0; 1; 2]);
      test "dispatch" (fun _ ->
          expect (dispatch reducer2 [] (`Add 1)) |> toEqual [1]);
      test "jsonify" (fun _ ->
          expect (jsonify reducer2 [0; 1; 2]) |> toEqual (Js.Json.parse "[0, 1, 2]")))
