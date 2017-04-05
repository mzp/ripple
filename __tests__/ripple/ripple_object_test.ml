open Jest
open Expect
open Ripple_reducer
open Ripple_object

let counter () = Ripple_primitive.int 0 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1)

let history () = Ripple_array.make [] Js.Json.string (fun xs ->
    function
    | `Inc -> "inc" :: xs
    | `Dec -> "dec" :: xs)

let keyed_object : ([`Inc | `Dec], 'a) Ripple_reducer.t =
  let value () =
   Ripple_primitive.int 0 (fun n ->
        function
        | `Inc -> n + 1
        | `Dec -> n - 1) in
  lift (value ()) [] (fun xs _ -> (string_of_int (List.length xs), 0) :: xs)

let () =
  describe "make" (fun _ ->
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
        |> toEqual (Js.Json.parse "{ \"value\": 1, \"history\": [\"inc\"] }")));
  describe "lift" (fun _ ->
    test "jsonify" (fun _ ->
        expect (jsonify keyed_object (initial keyed_object))
        |> toEqual (Js.Json.parse "{}"));
    test "dispatch" (fun _ ->
        expect (dispatch keyed_object (initial keyed_object) `Inc |> jsonify keyed_object)
        |> toEqual (Js.Json.parse "{ \"0\": 1 }")))
