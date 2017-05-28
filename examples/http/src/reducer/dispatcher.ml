let fetch dispatch url =
  let () =
    dispatch `Start
  in
    Axios.get url Js.null
    |> Js.Promise.then_ (fun response -> Js.Promise.resolve @@ dispatch @@ `Fetch response##data)
    |> ignore
