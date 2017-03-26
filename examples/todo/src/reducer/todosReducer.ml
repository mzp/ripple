type t = Todo.t list

let make () = Ripple.Array.lift (Todo.make ()) [] begin fun xs-> function
    | `Add text  ->
      xs @ [Todo.create (List.length xs) text]
    | _ ->
      xs
  end
