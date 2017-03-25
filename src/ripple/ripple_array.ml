let makeArray f xs =
  Ripple_json.array_ @@ Array.of_list @@ List.map f xs

let make state jsonify reducer = {
  Ripple_store.state;
  reducer;
  jsonify = makeArray jsonify
}

let lift { Ripple_store.jsonify; reducer } state f = {
  Ripple_store.state;
  jsonify = makeArray jsonify;
  reducer = fun xs action ->
    List.map (fun x -> reducer x action) @@ f xs action
}
