let fetch dispatch url =
  let () =
    dispatch `Start
  in
    Axios.get url Js.null
    |> Bs_promise.then_ (fun response -> dispatch @@ `Fetch response##data)
    |> ignore
