
# Note how me can define OurTrue before defining OurBool
alias OurTrue = OurBool(__mlir_attr.true)
alias OurFalse: OurBool = __mlir_attr.false

# This permits copying the object without defining __copyinit__
@register_passable("trivial")
struct OurBool:
    # var means the variable can be midified
    var value: __mlir_type.i1 # __mlir_type is used to use MLIR data types, simple bool

    fn __init__(out self):
        # Init with no argument
        self = OurFalse
    
    @implicit
    fn __init__(out self, value: __mlir_type.i1):
        self.value = value
    
    # This permits validate the MLIR boolean on a condition
    #fn __bool__(self) -> Bool:
    #    return Bool(self.value)
    fn __mlir_i1__(self) -> __mlir_type.i1:
        return self.value
    
    fn __eq__(self, rhs: OurBool) -> Self:
        var lhs_index = __mlir_op.`index.casts`[_type = __mlir_type.index](
            self.value
        )
        var rhs_index = __mlir_op.`index.casts`[_type = __mlir_type.index](
            rhs.value
        )

        return Self(
          __mlir_op.`index.cmp`[
              pred = __mlir_attr.`#index<cmp_predicate eq>`
          ](lhs_index, rhs_index)
        )
    
    fn __invert__(self) -> Self:
        return OurFalse if self == OurTrue else OurTrue

fn uninitialized_our_bool():
  var a: OurBool

def main():
    var a = OurBool()
    var b = a
    var e = OurTrue
    var f = OurFalse
    if e: print("It's true")
    var i = OurFalse
    if ~i: print("It's false!")
