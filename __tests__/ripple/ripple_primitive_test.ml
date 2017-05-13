open Jest
open Expect
open Ripple_reducer
open Ripple_primitive

type t = [ `Add of int | `Sub of int ]

let reducer_int : (t, 'a) Ripple_reducer.t  = int 42 (fun n ->
  function
    | `Add m -> n + m
    | `Sub m -> n - m)

let reducer_str : (t, 'a) Ripple_reducer.t = string "" (fun _ ->
  function
    | `Add _ -> "add"
    | `Sub _ -> "sub")

type point = {
  x : int;
  y : int
}

let reducer_record : (t, 'a) Ripple_reducer.t =
  let jsonify {x; y} =
    Ripple.Json.jsonify [%bs.obj { x; y }]
  in
    make jsonify { x = 0; y = 0 } (fun ({x; y}) ->
      function
        | `Add n -> { x = x + n; y = y}
        | `Sub n -> { x = x - n; y = y} )

let () =
    describe "int reducer" (fun _ ->
        test "inital" (fun _ ->
          expect (initial reducer_int) |> toBe 42);
        test "dispatch" (fun _ ->
            expect (dispatch reducer_int 42 (`Add 2)) |> toBe 44);
        test "jsonify" (fun _ ->
            expect (jsonify reducer_int 42) |> toBe (Js.Json.parseExn "42")));
    describe "string reducer" (fun _ ->
        test "inital" (fun _ ->
          expect (initial reducer_str) |> toBe "");
        test "dispatch" (fun _ ->
            expect (dispatch reducer_str ""  (`Sub 2)) |> toBe "sub");
        test "jsonify" (fun _ ->
            expect (jsonify reducer_str "foo") |> toBe (Js.Json.parseExn "\"foo\"")));
    describe "record.initial" (fun () ->
        test "initial" (fun _ ->
            expect (initial reducer_record) |> toEqual { x = 0; y = 0 });
        test "dispatch" (fun _ ->
            expect (dispatch reducer_record {x=0; y=0} (`Add 2)) |> toEqual { x=2; y=0 });
        test "jsonify" (fun () ->
            expect (jsonify reducer_record {x=0; y=0}) |> toEqual (Js.Json.parseExn "{ \"x\": 0, \"y\": 0 }")))
