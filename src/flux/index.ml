(* define action *)
module M = Store.Make(struct
  type t = [`Inc | `Dec]
end)

(* define store(primitive) *)
let n = M.number 42 (fun n ->
  function
    | `Inc -> n + 1
    | `Dec -> n - 1)

let s = M.string "zero" (fun _ ->
  function
    | `Inc -> "inc"
    | `Dec -> "dec"
)

let xs = M.array Json.number [1.;2.] (fun xs ->
  function
    | `Inc -> 0.0 :: xs
    | `Dec -> List.tl xs)

(* compose store(primitive) *)
let store =
  let nest =
    M.(("str", s) @+ ("n", n) @+ ("value", n) @+ empty)
  in
  M.(("nest", nest) @+ empty)

(* FFI *)
let inc = `Inc

let dec = `Dec

include M
