module type Action = sig
  type t
end

module Make(Action : Action) = struct
  module Store = struct
    type 'a t = {
      state : 'a;
      reducer: 'a -> Action.t -> 'a;
      jsonify: 'a -> Js.Json.t
    }

    let dispatch action ({ state; reducer} as store) =
      { store with state = reducer state action }

    let jsonify { state; jsonify } =
      jsonify state
  end

  module Primitive = struct
    type 'a t = 'a -> ('a -> Action.t -> 'a) -> 'a Store.t

    let store jsonify state reducer = {
      Store.jsonify;
      state;
      reducer
    }

    let int = store (fun n -> Ripple_json.number (float_of_int n))
    let number = store Ripple_json.number
    let string = store Ripple_json.string
    let array jsonify = store (fun xs -> Ripple_json.array_ @@ Array.of_list @@ List.map jsonify xs)
  end

  module Object = struct
    type 'a t = {
      state : 'a;
      reducer: 'a -> Action.t -> 'a;
      dictify: 'a -> Js.Json.t Js.Dict.t
    }

    let make { state; reducer; dictify } =
      {
        Store.state;
        reducer;
        jsonify = (fun x -> Ripple_json.object_ @@ dictify x)
      }

    let nil = {
      state=();
      reducer=(fun () _ -> ());
      dictify=Js.Dict.empty
    }

    let (@+) (key, s1) s2 = {
      state=(s1.Store.state, s2.state);
      reducer=(fun (x, y) action -> (s1.Store.reducer x action, s2.reducer y action));
      dictify=(fun (x, y) -> begin
        let dict = s2.dictify y in
        let () = Js.Dict.set dict key @@ s1.Store.jsonify x in
        dict
      end)
    }
  end
end
