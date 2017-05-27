type t = [
  | `Add of string
  | `Toggle of int
  | `Init
] [@@deriving variants]
