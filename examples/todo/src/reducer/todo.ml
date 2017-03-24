type t = {
  id : int;
  text : string;
  complete : bool
}

module Action = struct
  type t = [
  | `Add of int * string
  | `Toggle of int
] [@@deriving variants]
end

let empty = {
  id = ~-1;
  text="";
  complete=false
}

let reduce state = function
  | `Add (id,text) ->
      { id; text; complete=false}
  | `Toggle id ->
      if state.id = id then
        { state with complete=not state.complete }
      else
        state

let jsonify { id; text; complete } =
  Ripple.Json.jsonify [%bs.obj { id; text; complete } ]

