type ('a, 'b) t = {
  state : 'b;
  reducer: 'b -> 'a -> 'b;
  dictify: 'b -> Js.Json.t Js.Dict.t
}

let make { state; reducer; dictify } =
  {
    Ripple_store.state;
    reducer;
    jsonify = (fun x -> Ripple_json.object_ @@ dictify x)
  }

let nil = {
  state=();
  reducer=(fun () _ -> ());
  dictify=Js.Dict.empty
}

let (@+) (key, s1) s2 = {
  state=(s1.Ripple_store.state, s2.state);
  reducer=(fun (x, y) action -> (s1.Ripple_store.reducer x action, s2.reducer y action));
  dictify=(fun (x, y) -> begin
        let dict = s2.dictify y in
        let () = Js.Dict.set dict key @@ s1.Ripple_store.jsonify x in
        dict
      end)
}
