open Jest
open Expect
open Ripple_reducer

let reducer : ([`Inc | `Dec], int) t =
  make
    (fun state -> function
       | `Inc -> state + 1
       | `Dec -> state - 1)
    (fun n -> Js.Json.number @@ float_of_int n)

let _ =
  test "apply" (fun _ ->
      expect (apply reducer 42 `Dec) |> toBe 41);
  test "jsonify" (fun _ ->
      expect (jsonify reducer 42) |> toBe (Js.Json.number 42.));
  test "map" (fun _ ->
      let reducer' =
        map (fun state _ -> state + 2) reducer
      in
      expect (apply reducer' 42 `Inc) |> toBe 45)
