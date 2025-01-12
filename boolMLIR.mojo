
@register_passable("trivial")
struct OurBool:
    # var means the variable can be midified
    var value: __mlir_type.i1 # __mlir_type is used to use MLIR data types

    fn __init__(out self):
      # This is basically initializig value = false
      # MLIR operations are presented using ``
      self.value = __mlir_op.`index.bool.constant`[
        value = __mlir_attr.false, # This sets and attribute, by default the bool is false
      ]()

fn uninitialized_our_bool():
  var a: OurBool

def main():
    var a = OurBool()
    var b = a
