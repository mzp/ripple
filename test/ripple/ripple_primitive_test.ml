open Bs_mocha
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
  from_pair_suites __FILE__ [
    ("int.initial", fun () ->
        Eq (42, initial reducer_int));
    ("int.dispatch", fun () ->
        Eq (44, dispatch reducer_int 42 (`Add 2)));
    ("int.jsonify", fun () ->
        Eq (Js.Json.parse "42", jsonify reducer_int 42));

    ("string.initial", fun () ->
        Eq ("", initial reducer_str));
    ("string.dispatch", fun () ->
        Eq ("sub", dispatch reducer_str "" (`Sub 0)));
    ("string.jsonify", fun () ->
        Eq (Js.Json.parse "\"\"", jsonify reducer_str ""));

    ("record.initial", fun () ->
        Eq ({ x=0; y=0 }, initial reducer_record));
    ("record.dispatch", fun () ->
        Eq ({ x=2; y=0 }, dispatch reducer_record {x=0; y=0} (`Add 2)));
    ("record.jsonify", fun () ->
        Eq (Js.Json.parse "{ \"x\": 0, \"y\": 0 }",
            jsonify reducer_record {x=0; y=0}))
  ]
