let make () =
  Ripple.Value.json (fun x -> function
    | `Start -> Js.Json.null
    | `Fetch x -> x
    | _ -> x)
  |> Ripple.Lift.option Js.Json.null
