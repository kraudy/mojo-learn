from memory import Span
from sys.info import simdwidthof


fn contains[
    D: DType, //
](span: Span[Scalar[D]], value: Scalar[D]) -> Bool:
    """Verify if a given value is present in the Span.

    Parameters:
        D: The DType of the scalars stored in the Span.

    Args:
        span: The span to verify.
        value: The value to find.

    Returns:
        True if the value is contained in the Span, False otherwise.
    """

    alias widths = (256, 128, 64, 32, 16, 8)
    var ptr = span.unsafe_ptr()
    var length = len(span)
    var processed = 0

    @parameter
    for i in range(len(widths)):
        alias w = widths.get[i, Int]()

        print("width D: ", simdwidthof[D]())
        #print(D)
        @parameter
        if simdwidthof[D]() >= w:
            print("w: ", w)
            for _ in range((length - processed) // w):
                print('ptr + processed: ', ptr + processed)
                print('(ptr + processed).load[width=w](): ', (ptr + processed).load[width=w]())
                if value in (ptr + processed).load[width=w]():
                    # We load 
                    return True
                processed += w

    for i in range(length - processed):
        if ptr[processed + i] == value:
            return True
    return False

fn main():
    #items = List[UInt8](1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
    items = List[Byte](1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
    span = Span(items)
    print(contains(span, 0)) # False
    print(contains(span, 16)) # False
    for item in items:
        print(contains(span, item[])) # True