let makeArray f xs =
  Ripple_json.array_ @@ Array.of_list @@ List.map f xs

let make initial jsonify f = {
  Ripple_reducer.initial;
  f;
  jsonify = makeArray jsonify
}

let lift { Ripple_reducer.jsonify; f } initial g = {
  Ripple_reducer.initial;
  jsonify = makeArray jsonify;
  f = fun xs action ->
    List.map (fun x -> f x action) @@ g xs action
}
