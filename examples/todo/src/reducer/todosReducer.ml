type t = TodoReducer.t list

let make () = Ripple.Array.lift (TodoReducer.make ()) [] begin fun xs-> function
    | `Add text  ->
      xs @ [TodoReducer.create (List.length xs) text]
    | _ ->
      xs
  end
