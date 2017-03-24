(* define action *)
module M = Ripple.Store(struct
  type t = Todo.Action.t
end)

let store =
  let open M.Object in
  M.Store.create @@ make @@
    ("todos", M.Primitive.array Todo.jsonify [] Todos.reduce)
    @+ nil

include Todo.Action
