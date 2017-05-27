open Jest
open Expect
open Ripple_reducer

let counter () = Ripple_lift.option 0 @@ Ripple_value.int (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1
    | _ -> n)

let history () = Ripple_lift.option "" @@ Ripple_value.string (fun str ->
    function
    | `Inc -> "inc"
    | `Dec -> "dec"
    | _ -> str)

let () =
  describe "make" (fun _ ->
      let (f, value) =
        Ripple_object.(builder @@ fun t ->
            t
            |> field "value" (counter ())
            |> field "history" (history ())) in
      let x =
        apply f value `Init in
      test "jsonify" (fun _ ->
          expect (jsonify f x)
          |> toEqual (Js.Json.parseExn "{ \"value\": 0, \"history\": \"\" }"));
      test "apply" (fun _ ->
          expect (apply f x `Inc |> jsonify f)
          |> toEqual (Js.Json.parseExn "{ \"value\": 1, \"history\": \"inc\" }")))
