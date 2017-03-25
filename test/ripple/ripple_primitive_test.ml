open Bs_mocha
open Ripple_store
open Ripple_primitive

type t = [ `Add of int | `Sub of int ]

let store_int : (t, 'a) Ripple_store.t = int 42 (fun n ->
  function
    | `Add m -> n + m
    | `Sub m -> n - m)

let store_str : (t, 'a) Ripple_store.t = string "" (fun _ ->
  function
    | `Add _ -> "add"
    | `Sub _ -> "sub")

type point = {
  x : int;
  y : int
}

let store_record : (t, 'a) Ripple_store.t =
  let jsonify {x; y} =
    Ripple.Json.jsonify [%bs.obj { x; y }]
  in
    make jsonify { x = 0; y = 0 } (fun ({x; y}) ->
      function
        | `Add n -> { x = x + n; y = y}
        | `Sub n -> { x = x - n; y = y} )

let () =
  from_pair_suites __FILE__ [
    ("int.value", fun () -> Eq (42, value store_int));
    ("int.dispatch", fun () -> Eq (44, value @@ dispatch (`Add 2) store_int));
    ("int.jsonify", fun () -> Eq (Js.Json.parse "42", jsonify store_int));
    ("string.value", fun () -> Eq ("", value store_str));
    ("string.dispatch", fun () -> Eq ("sub", value @@ dispatch (`Sub 0) store_str));
    ("string.jsonify", fun () -> Eq (Js.Json.parse "\"\"", jsonify store_str));
    ("record.value", fun () -> Eq ({ x=0; y=0 }, value store_record));
    ("record.dispatch", fun () -> Eq ({ x=2; y=0 }, value @@ dispatch (`Add 2) store_record));
    ("record.jsonify", fun () -> Eq (Js.Json.parse "{ \"x\": 0, \"y\": 0 }", jsonify store_record))
  ]