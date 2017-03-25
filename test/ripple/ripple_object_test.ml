open Bs_mocha
open Ripple_store
open Ripple_primitive
open Ripple_object

let counter () = int 0 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1)

let history () = Ripple_array.make [] Ripple_json.string (fun xs ->
    function
    | `Inc -> "inc" :: xs
    | `Dec -> "dec" :: xs)

let store =
  make @@ begin
    "value" +> counter () @+
    "history" +> history () @+
    nil
  end

let () =
  from_pair_suites __FILE__ [
    ("jsonify", fun () ->
        Eq (Js.Json.parse "{ \"value\": 0, \"history\": [] }",
            jsonify store));
    ("dispatch", fun () ->
        Eq (Js.Json.parse "{ \"value\": 1, \"history\": [\"inc\", \"inc\", \"dec\"] }",
            store |> dispatch `Dec |> dispatch `Inc |> dispatch `Inc |> jsonify));
  ]
