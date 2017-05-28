let option default reducer =
  let redux state action =
    match state with
    | None -> Some default
    | Some s -> Some (Ripple_reducer.apply reducer s action)
  in
  let jsonify = function
    | None -> Js.Json.null
    | Some x -> Ripple_reducer.jsonify reducer x
  in
  Ripple_reducer.make redux jsonify

let array reducer =
  let redux xs action =
    List.map (fun x -> Ripple_reducer.apply reducer x action) xs in
  let jsonify xs =
    Js.Json.array @@ Array.of_list @@ List.map (Ripple_reducer.jsonify reducer) xs in
  Ripple_reducer.make redux jsonify

let make_object jsonify xs =
  let dict =
    Js.Dict.empty () in
  let () =
    List.iter (fun (k,v) -> Js.Dict.set dict k @@ jsonify v) xs in
  Js.Json.object_ dict

let object_ reducer =
  let jsonify =
    make_object @@ Ripple_reducer.jsonify reducer in
  let redux xs action =
    List.map (fun (k,x)  -> (k, Ripple_reducer.apply reducer x action)) xs
  in
  Ripple_reducer.make redux jsonify
