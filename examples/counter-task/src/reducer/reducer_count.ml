let make () =
  Ripple.Value.int (fun n _ -> n + 1)
  |> Ripple.Lift.option 0
