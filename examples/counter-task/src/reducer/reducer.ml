let make () =
  let open Ripple.Object in
  make @@
    ("value" +> Reducer_value.make ()) @+
    ("count" +> Reducer_count.make ()) @+
    nil
