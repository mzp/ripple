let make () =
  let open Ripple.Object in
  builder (fun t ->
      t
      |> field "todos" (Reducer_todos.make ()))
