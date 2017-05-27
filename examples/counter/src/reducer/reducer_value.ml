let make () =
  Ripple.Value.int begin fun n -> function
    | `Inc -> n + 1
    | `Dec -> n - 1
    | `Set m -> m
    | _ -> n
  end
  |> Ripple.Lift.option 0
