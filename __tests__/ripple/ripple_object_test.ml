open Jest
open Expect
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
  test "jsonify" (fun _ ->
      expect (jsonify obj_ (initial obj_))
      |> toEqual (Js.Json.parse "{ \"value\": 0, \"history\": [] }"));
  test "dispatch" (fun _ ->
      expect (dispatch obj_ (initial obj_) `Inc |> jsonify obj_)
      |> toEqual (Js.Json.parse "{ \"value\": 1, \"history\": [\"inc\"] }"))
