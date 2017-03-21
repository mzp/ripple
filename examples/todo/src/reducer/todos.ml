type t = Todo.t list

type action = Todo.action

let reduce state action =
  match action with
    | `Add _ ->
        state @ [Todo.reduce Todo.empty action]
    | `Toggle _ ->
        List.map (fun todo -> Todo.reduce todo action) state
