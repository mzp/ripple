(* define action *)
module M = Ripple.Store(struct
  type t = Todo.action
end)

let store =
  let open M.Object in
  make @@
    ("todos", M.Primitive.array Todo.jsonify [] Todos.reduce)
    @+ nil

let add n s = `Add (n,s)
let toggle n = `Toggle n
include M.Dispatch
