let store () = Ripple.Primitive.int 0 begin fun n -> function
  | `Inc -> n + 1
  | `Dec -> n - 1
  | `Set m -> m
end
