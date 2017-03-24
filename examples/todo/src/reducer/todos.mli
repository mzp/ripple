type t = Todo.t list

val reduce : t -> Todo.Action.t -> t
