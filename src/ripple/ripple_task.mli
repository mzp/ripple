type 'a t

(* effect *)
val take : 'a t -> 'a Lwt.t
val take_if : 'a t -> f:('a -> 'b option) ->  ('b, unit) Lwt_result.t
val put : 'a t -> 'a -> unit Lwt.t
val call : 'a Js.Promise.t -> ('a, Js.Promise.error) Lwt_result.t

(* infix *)
module Infix : sig
  include module type of Lwt.Infix
  val (>?=) : ('a, 'e) Lwt_result.t -> ('a -> 'b Lwt.t) -> ('b, 'e) Lwt_result.t
end

(* task *)
val loop : ('a t -> unit Lwt.t) -> ('a t -> unit Lwt.t)
val make : ('a t -> 'b Lwt.t) -> ('a t -> unit Lwt.t)

include module type of Infix

module Middleware : sig
  val create : ('a t -> unit Lwt.t) list -> ('a -> unit) -> 'a -> unit
end
