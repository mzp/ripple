type ('a, 'b) t = {
  redux: 'b -> 'a -> 'b;
  dictify: 'b -> Js.Json.t Js.Dict.t;
  value: 'b
}

let nil = {
  redux=(fun () _ -> ());
  dictify=Js.Dict.empty;
  value=()
}

let field key r {redux; dictify; value} =
  let redux (x, y) action =
    (Ripple_reducer.apply r x action, redux y action) in
  let dictify (x, y) =
    let dict =
      dictify y in
    let () =
      Js.Dict.set dict key @@ Ripple_reducer.jsonify r x in
    dict in
  let value =
    (None, value) in
  { redux; dictify; value}

let reducer { redux; dictify } =
  let jsonify x =
    Js.Json.object_ @@ dictify x in
  Ripple_reducer.make redux jsonify

let obj_field key (f, x) =
  field key (Ripple_lift.option x f)

let builder f =
  let { value } as obj =
    f nil in
  (reducer obj, value)
