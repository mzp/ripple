module Reducer = Ripple_reducer
module Primitive = Ripple_primitive
module Object = Ripple_object
module Array = Ripple_array
module Redux = Ripple_redux

module Json = struct
  external jsonify : 'a Js.t -> Js.Json.t = "%identity"
end
