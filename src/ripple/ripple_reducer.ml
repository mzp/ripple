type ('a, 'b) t = {
  f: 'b -> 'a -> 'b;
  initial : 'b;
  jsonify: 'b -> Js.Json.t
}

let initial { initial } = initial
let jsonify { jsonify } = jsonify
let dispatch {f} = f
