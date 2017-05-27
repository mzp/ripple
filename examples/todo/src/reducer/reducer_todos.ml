type t = Reducer_todo.t list

let make () =
  Ripple.Lift.array (Reducer_todo.make ())
  |> Ripple.Reducer.map (fun xs-> function
    | `Add text  ->
      xs @ [Reducer_todo.create (List.length xs) text]
    | _ ->
      xs)
  |> Ripple.Lift.option []
