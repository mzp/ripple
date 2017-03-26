let make () =
  let open Ripple.Object in
  make @@
    ("value" +> ValueReducer.make ()) @+
    ("count" +> CountReducer.make ()) @+
    nil
