external string : string -> Js.Json.t = "%identity"
external number : float -> Js.Json.t = "%identity"
external boolean : Js.boolean -> Js.Json.t = "%identity"
external object_ : Js.Json.t Js_dict.t -> Js.Json.t = "%identity"
external array_ : Js.Json.t array -> Js.Json.t = "%identity"
external stringArray : string array -> Js.Json.t = "%identity"
external numberArray : float array -> Js.Json.t = "%identity"
external booleanArray : Js.boolean array -> Js.Json.t = "%identity"
external objectArray : Js.Json.t Js.Dict.t array -> Js.Json.t = "%identity"
external null : Js.Json.t = "" [@@bs.val]

let int n = number (float_of_int n)
