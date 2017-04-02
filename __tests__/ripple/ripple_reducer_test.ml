open Jest
open Expect
open Ripple_reducer

let reducer = {
  initial=42;
  f=(fun n ->
    function
      | `Add m -> n + m
      | `Sub m -> n - m);
  jsonify=(fun n -> Js.Json.number @@ float_of_int n)
}

let _ =
  test "value" (fun _ ->
      expect (initial reducer) |> toBe 42);
  test "dispatch" (fun _ ->
      expect (dispatch reducer 42 (`Sub 2)) |> toBe 40);
  test "jsonify" (fun _ ->
      expect (jsonify reducer 42) |> toBe (Js.Json.number 42.))
