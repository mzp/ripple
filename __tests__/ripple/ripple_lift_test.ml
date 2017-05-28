open Jest
open Expect
open Ripple_reducer
open Ripple_lift

let value () =
  Ripple_value.int (fun n ->
      function
      | `Add m -> n + m
      | `Sub m -> n - m)

let _ =
  describe "option" (fun _ ->
      let reducer =
        option 0 (value ()) in
      test "apply" (fun _ ->
          expect (apply reducer None (`Add 0)) |> toEqual (Some 0));
      test "jsonify" (fun _ ->
          expect (jsonify reducer None) |> toEqual (Js.Json.number 0.)));
  describe "array" (fun _ ->
      let reducer =
        array (value ()) in
      test "apply" (fun _ ->
          expect (apply reducer [0; 1] (`Add 1)) |> toEqual [1; 2]);
      test "jsonify" (fun _ ->
          expect (jsonify reducer [0; 1; 2]) |> toEqual (Js.Json.parseExn "[0, 1, 2]")));
  describe "object" (fun _ ->
      let reducer =
        object_ (value ()) in
      let x =
        [("foo", 1); ("bar", 2)] in
      test "apply" (fun _ ->
          expect (apply reducer x (`Add 1)) |> toEqual [("foo", 2); ("bar", 3)]);
      test "jsonify" (fun _ ->
          expect (jsonify reducer x) |> toEqual (Js.Json.parseExn "{ \"foo\": 1, \"bar\" : 2 }")))
