module type Action = sig
  type t
end

module Make(Action : Action) = struct
  type 'a t = {
    state : 'a;
    reducer: 'a -> Action.t -> 'a;
    jsonify: 'a -> Js_json.t
  }
  type 'a store = 'a -> ('a -> Action.t -> 'a) -> 'a t

  let dispatch ({ state; reducer} as store) action =
    { store with state = reducer state action }

  let jsonify { state; jsonify } =
    jsonify state

  let number n f = {
    state=n;
    reducer=f;
    jsonify=(fun n -> Json.number (float_of_int n))
  }

  let float (n : float) f = {
    state=n;
    reducer=f;
    jsonify=(fun n -> Json.number n)
  }

  let string (str : string) f = {
    state=str;
    reducer=f;
    jsonify=(fun str -> Json.string str)
  }

  let array json (xs : 'a list) f = {
    state=xs;
    reducer=f;
    jsonify=(fun xs -> Json.array_ (Array.of_list (List.map json xs)))
  }

  let empty = {
    state=();
    reducer=(fun () _ -> ());
    jsonify=(fun () -> Json.object_ (Js.Dict.empty ()))
  }

  let copy_value dest src =
    let keys =
      Js.Dict.keys src
    in
    Array.iter
      (fun key ->
        match Js.Dict.get src key with
        | Some v -> Js.Dict.set dest key v
        | None -> ())
      keys


  let (@+) (k1, s1)  s2 = {
    state=(s1.state, s2.state);
    reducer=(fun (x,y) action -> (s1.reducer x action, s2.reducer y action));
    jsonify=(fun (x,y) ->
      let dict = Js.Dict.empty () in
      let () = Js.Dict.set dict k1 (s1.jsonify x) in
      let () =
        match Js.Json.reify_type (s2.jsonify y) with
        | (Js.Json.Object, d2) -> copy_value dict d2
        | _ -> failwith "ill type"
      in
      Json.object_ dict
    )
  }
end
