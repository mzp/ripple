type response = <
  data: Js.Json.t;
  status: int;
  statustext: string;
  headers: string Js.Dict.t;
  config: Js.Json.t
> Js.t

type config = Js.Json.t

external request : config -> response Js.Promise.t = "get" [@@bs.module "axios"]
external get : string -> config Js.null -> response Js.Promise.t = "get" [@@bs.module "axios"]
external delete: string -> config Js.null -> response Js.Promise.t = "delete" [@@bs.module "axios"]
external head: string -> config Js.null -> response Js.Promise.t = "head" [@@bs.module "axios"]
external post: string -> 'a Js.null -> config Js.null -> response Js.Promise.t = "post" [@@bs.module "axios"]
external put: string -> config Js.null -> response Js.Promise.t = "put" [@@bs.module "axios"]
external patch: string -> config Js.null -> response Js.Promise.t = "patch" [@@bs.module "axios"]
