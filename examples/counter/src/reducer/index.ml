(* define action *)
module Action = struct
  type t = [
    | `Inc
    | `Dec
    | `Set of int ] [@@deriving variants]
end

module M = Ripple.Store(struct
  type t = Action.t
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
  M.Store.create @@ make @@
    ("value", value) @+
    ("count", count) @+
    nil

(* FFI *)
include Action
