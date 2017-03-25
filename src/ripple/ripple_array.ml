let make state jsonify reducer = {
  Ripple_store.state;
  reducer;
  jsonify = fun xs -> Ripple_json.array_ @@ Array.of_list @@ List.map jsonify xs
}
