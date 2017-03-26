let fetch (dispatch : Ripple.Redux.action -> unit) url =
  let () =
    dispatch (Ripple.Redux.create_action `Start)
  in
    Axios.get url Js.null
    |> Bs_promise.then_ (fun response -> dispatch @@ Ripple.Redux.create_action @@ `Fetch response##data)
    |> ignore
