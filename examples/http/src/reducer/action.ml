type t = [
  | `Start
  | `Fetch of Js.Json.t
] [@@deriving variants]
