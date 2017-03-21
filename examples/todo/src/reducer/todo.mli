type t

type action = [
  | `Add of int * string
  | `Toggle of int
]

val empty : t

val reduce : t -> action -> t

val jsonify : t -> Js.Json.t
