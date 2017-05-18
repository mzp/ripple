module Context : sig
  type 'a t = {
    channel : 'a Lwt_mvar.t;
    dispatch : 'a -> unit
  }
  val take : 'a t -> 'a Lwt.t
  val take_if : f:('a -> 'b option) -> 'a t -> ('b, unit) Lwt_result.t
  val put : 'a t -> 'a -> unit Lwt.t
  val call : 'a Js.Promise.t -> ('a, Js.Promise.error) Lwt_result.t

  module Infix : sig
    include module type of Lwt.Infix
    val (>?=) : ('a, 'e) Lwt_result.t -> ('a -> 'b Lwt.t) -> ('b, 'e) Lwt_result.t
  end

  include module type of Infix
end

module Task : sig
  type 'a t = 'a Context.t -> unit Lwt.t
  val loop : 'a t -> 'a t

  val ignore : ('a Context.t -> 'b Lwt.t) -> 'a t
end

module Middleware : sig
  val create : 'a Task.t list -> ('a -> unit) -> 'a -> unit
end
