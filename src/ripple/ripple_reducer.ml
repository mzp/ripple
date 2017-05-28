type ('a, 'b) t = {
  redux : 'b -> 'a -> 'b;
  jsonify : 'b -> Js.Json.t
}

let make redux jsonify =
  { redux; jsonify }

let apply {redux} state action =
  redux state action

let jsonify {jsonify} =
  jsonify

let map f ({ jsonify } as g) =
  let redux state action =
    apply g (f state action) action
  in
  make redux jsonify
