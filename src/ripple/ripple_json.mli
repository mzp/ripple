(* backport: https://github.com/bloomberg/bucklescript/pull/1382 *)
external string : string -> Js.Json.t = "%identity"
val int : int -> Js.Json.t
external number : float -> Js.Json.t = "%identity"
external boolean : Js.boolean -> Js.Json.t = "%identity"
external object_ : Js.Json.t Js_dict.t -> Js.Json.t = "%identity"
external array_ : Js.Json.t array -> Js.Json.t = "%identity"
external stringArray : string array -> Js.Json.t = "%identity"
external numberArray : float array -> Js.Json.t = "%identity"
external booleanArray : Js.boolean array -> Js.Json.t = "%identity"
external objectArray : Js.Json.t Js.Dict.t array -> Js.Json.t = "%identity"
