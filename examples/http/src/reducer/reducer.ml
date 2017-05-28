let make () =
  let open Ripple.Object in
  builder (fun t ->
    t
    |> field "ready" (Reducer_ready.make ())
    |> field "data" (Reducer_data.make ()))
