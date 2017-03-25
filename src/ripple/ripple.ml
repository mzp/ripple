module Store = Ripple_store
module Primitive = Ripple_primitive
module Object = Ripple_object
module Array = Ripple_array

module Json = struct
  external jsonify : 'a Js.t -> Js.Json.t = "%identity"
end
