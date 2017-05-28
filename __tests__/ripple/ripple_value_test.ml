open Jest
open Expect
open Ripple_reducer
open Ripple_value

type t = [ `Add of int | `Sub of int ]

let reducer_int : (t, 'a) Ripple_reducer.t  = int (fun n ->
  function
    | `Add m -> n + m
    | `Sub m -> n - m)

let reducer_str : (t, 'a) Ripple_reducer.t = string (fun _ ->
  function
    | `Add _ -> "add"
    | `Sub _ -> "sub")

type point = {
  x : int;
  y : int
}

let () =
    describe "int reducer" (fun _ ->
        test "apply" (fun _ ->
            expect (apply reducer_int 42 (`Add 2)) |> toBe 44);
        test "jsonify" (fun _ ->
            expect (jsonify reducer_int 42) |> toBe (Js.Json.parseExn "42")));
    describe "string reducer" (fun _ ->
        test "apply" (fun _ ->
            expect (apply reducer_str ""  (`Sub 2)) |> toBe "sub");
        test "jsonify" (fun _ ->
            expect (jsonify reducer_str "foo") |> toBe (Js.Json.parseExn "\"foo\"")))
