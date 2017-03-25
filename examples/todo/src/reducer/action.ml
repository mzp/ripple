type t = [
  | `Add of string
  | `Toggle of int
] [@@deriving variants]
