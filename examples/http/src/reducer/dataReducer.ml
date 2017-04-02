let make () =
  Ripple.Primitive.json Js.Json.null (fun _ -> function
    | `Start -> Js.Json.null
    | `Fetch x -> x)
