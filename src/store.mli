module type Action = sig
  type t
end

module Make(Action : Action) : sig
  type 'a t
  type 'a store = 'a -> ('a -> Action.t -> 'a) -> 'a t
  val jsonify : 'a t -> Js_json.t
  val number : int store
  val float : float store
  val string : string store
  val array : ('a -> Js.Json.t) -> 'a list store
  val (@+) : (string * 'a t) -> 'b t -> ('a * 'b) t
  val empty : unit t
end
