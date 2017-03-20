(* define action *)
module M = Ripple.Store(struct
  type t = [ `Inc | `Dec | `Set of int ]
end)

(* define reducer *)
let value = M.Primitive.int 0 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1
    | `Set m -> m)

let count = M.Primitive.int 0 (fun n ->
  function
    | `Inc | `Dec -> n + 1
    | `Set _ -> 0)

let store =
  let open M.Object in
  make @@
    ("value", value) @+
    ("count", count) @+
    nil

(* FFI *)
let inc = `Inc
let dec = `Dec
let set n = `Set n

include M.Dispatch
