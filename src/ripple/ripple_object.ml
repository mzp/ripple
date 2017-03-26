type ('a, 'b) t = {
  initial: 'b;
  f: 'b -> 'a -> 'b;
  dictify: 'b -> Js.Json.t Js.Dict.t
}

let make { initial; f; dictify } =
  {
    Ripple_reducer.initial;
    f;
    jsonify = (fun x -> Ripple_json.object_ @@ dictify x)
  }

let nil = {
  initial=();
  f=(fun () _ -> ());
  dictify=Js.Dict.empty
}

let (@+) (key, s1) s2 = {
  initial=(s1.Ripple_reducer.initial, s2.initial);
  f=(fun (x, y) action -> (s1.Ripple_reducer.f x action, s2.f y action));
  dictify=(fun (x, y) -> begin
        let dict = s2.dictify y in
        let () = Js.Dict.set dict key @@ s1.Ripple_reducer.jsonify x in
        dict
      end)
}

let (+>) x y = (x, y)
