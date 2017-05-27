let make () =
  Ripple.Object.(
    builder (fun t ->
        t
        |> field "value" (Reducer_value.make ())
        |> field "count" (Reducer_count.make ())))
