(* define action *)
type action  = [`Inc | `Dec | `Set of int]
module M = Store.Make(struct
  type t = action
end)

(* define store(primitive) *)
let n = M.number 42 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1
    | `Set m -> m)

let s = M.string "zero" (fun _ ->
  function
    | `Inc -> "inc"
    | `Dec -> "dec"
    | `Set _ -> "set"
)

let xs = M.array Json.number [1.;2.] (fun xs ->
  function
    | `Inc -> 0.0 :: xs
    | `Dec -> List.tl xs
    | _ -> xs )

(* compose store(primitive) *)
let store =
  let nest =
    M.(("str", s) @+ ("n", n) @+ ("value", n) @+ empty)
  in
  M.(("nest", nest) @+ empty)

(* FFI *)
let inc = `Inc

let dec = `Dec

let double_ = `Double

let set n = `Set n

include M

let dispatch store = function
  | `Double ->
      M.dispatch (M.dispatch store `Inc) `Inc
  | #action as x -> M.dispatch store x
