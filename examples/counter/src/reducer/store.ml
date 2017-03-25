let store () =
  let open Ripple.Object in
  make @@
    ("value" +> ValueStore.store ()) @+
    ("count" +> CountStore.store ()) @+
    nil
