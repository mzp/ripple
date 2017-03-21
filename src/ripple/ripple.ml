module Store = Ripple_store.Make

module Json = struct
  external jsonify : 'a Js.t -> Js.Json.t = "%identity"
end
