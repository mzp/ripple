module Context : sig
  type 'a t = {
    channel : 'a Lwt_mvar.t;
    dispatch : 'a -> unit
  }
  val take : 'a t -> 'a Lwt.t
  val put : 'a t -> 'a -> unit Lwt.t
  val call : 'a Js.Promise.t -> 'a Lwt.t
end

module Task : sig
  type 'a t = 'a Context.t -> unit Lwt.t
  val loop : 'a t -> 'a t
end

module Middleware : sig
  val create : 'a Task.t list -> ('a -> unit) -> 'a -> unit
end
