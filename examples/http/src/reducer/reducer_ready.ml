let make () =
  Ripple.Value.bool (fun x -> function
    | `Start -> false
    | `Fetch _ -> true
    | _ -> x)
  |> Ripple.Lift.option false
