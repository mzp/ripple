open Bs_mocha
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

let () =
  from_pair_suites __FILE__ [
    ("make.initial", fun () ->
      Eq ([], initial reducer1));
    ("make.dispatch", fun () ->
      Eq ([1], dispatch reducer1 [] (`Cons 1)));
    ("make.jsonify", fun () ->
      Eq (
        Js.Json.parse "[1]",
        jsonify reducer1 [1]));

    ("lift.initial", fun () ->
        Eq ([0; 1; 2], initial reducer2));
    ("lift.dispatch", fun () ->
      Eq ([1], dispatch reducer2 [] (`Add 1)));
    ("lift.jsonify", fun () ->
        Eq (Js.Json.parse "[0, 1, 2]",
            jsonify reducer2 [0; 1; 2]))
  ]
