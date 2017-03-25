open Bs_mocha
open Ripple_store

let store = {
  state=42;
  reducer=(fun n ->
    function
      | `Add m -> n + m
      | `Sub m -> n - m);
  jsonify=(fun n -> Ripple_json.number @@ float_of_int n)
}

let () =
  from_pair_suites __FILE__ [
    ("value", fun () -> Eq (42, value store));
    ("dispatch", fun () -> Eq (40, value @@ dispatch (`Sub 2) store));
    ("jsonify", fun () -> Eq (Ripple_json.number 42., jsonify  store))
  ]
