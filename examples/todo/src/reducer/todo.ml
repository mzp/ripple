type t = {
  id : int;
  text : string;
  complete : bool
}

let create id text = {
  id;
  text;
  complete=false
}

let empty = create ~-1 ""

let reducer state = function
  | `Toggle id ->
      if state.id = id then
        { state with complete=not state.complete }
      else
        state
  | _ ->
    state

let jsonify { id; text; complete } =
  Ripple.Json.jsonify [%bs.obj { id; text; complete } ]

let store () =
  Ripple.Primitive.make jsonify empty reducer
