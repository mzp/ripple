let make () =
  let open Ripple.Object in
  builder (fun t ->
      t
      |> field "value" (Reducer_value.make ())
      |> field "count" (Reducer_count.make ()))

