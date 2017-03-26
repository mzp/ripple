open Bs_mocha
open Ripple_reducer
open Ripple_object

let counter () = Ripple_primitive.int 0 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1)

let history () = Ripple_array.make [] Ripple_json.string (fun xs ->
    function
    | `Inc -> "inc" :: xs
    | `Dec -> "dec" :: xs)



let () =
  let obj_ =
    make @@ begin
      "value" +> counter () @+
      "history" +> history () @+
      nil
    end
  in
  from_pair_suites __FILE__ [
    ("jsonify", fun () ->
        Eq (Js.Json.parse "{ \"value\": 0, \"history\": [] }",
            jsonify obj_ (initial obj_)));
    ("dispatch", fun () ->
        Eq (Js.Json.parse "{ \"value\": 1, \"history\": [\"inc\"] }",
            dispatch obj_ (initial obj_) `Inc
            |> jsonify obj_))
  ]
