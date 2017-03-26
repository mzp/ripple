let make () =
  let open Ripple.Object in
  make @@
    ("todos", TodosReducer.make ())
    @+ nil
