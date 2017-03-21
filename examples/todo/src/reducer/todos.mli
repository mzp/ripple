type t = Todo.t list

type action = Todo.action

val reduce : t -> action -> t
