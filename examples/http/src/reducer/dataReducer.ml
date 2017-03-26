let make () =
  Ripple.Primitive.make Obj.magic Js.null (fun _ -> function
    | `Start -> Js.null
    | `Fetch x -> x)
