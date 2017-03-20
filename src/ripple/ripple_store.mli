module type Action = sig
  type t
end

module Make(Action : Action) : sig
  module Dispatch : sig
    type 'a t
    val dispatch : Action.t -> 'a t -> 'a t
    val jsonify : 'a t -> Js.Json.t
  end

  module Primitive : sig
    type 'a t = 'a -> ('a -> Action.t -> 'a) -> 'a Dispatch.t
    val number : float t
    val int : int t
    val string : string t
    val array : ('a -> Js.Json.t) -> 'a list t
  end

  module Object : sig
    type 'a t
    val make : 'a t -> 'a Dispatch.t

    val nil : unit t
    val (@+) : (string * 'a Dispatch.t) -> 'b t -> ('a * 'b) t
  end
end