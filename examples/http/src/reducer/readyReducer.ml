let make () =
  Ripple.Primitive.bool false (fun _ -> function
    | `Start -> false
    | `Fetch _ -> true)
