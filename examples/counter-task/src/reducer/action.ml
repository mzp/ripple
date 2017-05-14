type t = [
  | `Inc
  | `Dec
  | `DelayedInc
  | `Set of int ] [@@deriving variants]
