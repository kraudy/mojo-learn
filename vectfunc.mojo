from memory import Span
from sys.info import simdwidthof


fn apply[
    D: DType,
    O: MutableOrigin, //,
    func: fn[w: Int] (SIMD[D, w]) -> SIMD[D, w],
](span: Span[Scalar[D], O]):
    """Apply the function to the `Span` inplace.

    Parameters:
        D: The DType.
        O: The origin of the `Span`.
        func: The function to evaluate.
    """

    alias widths = (256, 128, 64, 32, 16, 8, 4)
    var ptr = span.unsafe_ptr()
    var length = len(span)
    var processed = 0

    @parameter
    for i in range(len(widths)):
        alias w = widths.get[i, Int]()

        @parameter
        if simdwidthof[D]() >= w:
            for _ in range((length - processed) // w):
                var p_curr = ptr + processed
                p_curr.store(func(p_curr.load[width=w]()))
                processed += w

    for i in range(length - processed):
        (ptr + processed + i).init_pointee_move(func(ptr[processed + i]))


fn main():
    items = List[Byte](
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
    )
    twice = items
    span = Span(twice)

    fn _twice[w: Int](x: SIMD[DType.uint8, w]) -> SIMD[DType.uint8, w]:
        return x * 2

    apply[func=_twice](span)
    for i in range(len(items)):
        print(span[i] == items[i] * 2)  # True