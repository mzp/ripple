type t = Todo.t list

let store () = Ripple.Array.lift (Todo.store ()) [] begin fun xs-> function
    | `Add text  ->
      xs @ [Todo.create (List.length xs) text]
    | _ ->
      xs
  end
