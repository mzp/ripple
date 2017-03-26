let make () =
  let open Ripple.Object in
  make @@
    "ready" +> ReadyReducer.make () @+
    "data" +> DataReducer.make () @+
    nil
