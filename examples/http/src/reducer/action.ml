type t = [
  | `Inc
  | `Dec
  | `Set of int ] [@@deriving variants]
