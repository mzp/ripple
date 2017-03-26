open Bs_mocha
open Ripple_reducer

let reducer = {
  initial=42;
  f=(fun n ->
    function
      | `Add m -> n + m
      | `Sub m -> n - m);
  jsonify=(fun n -> Ripple_json.number @@ float_of_int n)
}

let () =
  from_pair_suites __FILE__ [
    ("value", fun () -> Eq (42, initial reducer));
    ("dispatch", fun () -> Eq (40, dispatch reducer 42 (`Sub 2)));
    ("jsonify", fun () -> Eq (Ripple_json.number 42., jsonify reducer 42))
  ]
