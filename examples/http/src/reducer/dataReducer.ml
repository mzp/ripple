let make () =
  Ripple.Primitive.json Ripple.Json.null (fun _ -> function
    | `Start -> Ripple.Json.null
    | `Fetch x -> x)
