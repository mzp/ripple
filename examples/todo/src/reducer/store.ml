let store () =
  let open Ripple.Object in
  make @@
    ("todos", Todos.store ())
    @+ nil
