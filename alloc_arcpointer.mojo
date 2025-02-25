from memory import UnsafePointer, ArcPointer

fn unsafe_example():
    # Allocate memory for 3 float64 elements
    var ptr = UnsafePointer[Float64].alloc(3)

    # Assign values using pointer indexing
    ptr[0] = 1.0
    ptr[1] = 2.5
    ptr[2] = 3.7

    # Iterate over the elements
    for i in range(3):
        print(ptr[i])

    # Free the memory
    ptr.free()

fn arcpointer_example():
    # Allocate memory for 3 Float64 elements using UnsafePointer
    var raw_ptr = UnsafePointer[Float64].alloc(3)

    # Assign values to the allocated memory
    raw_ptr[0] = 1.0
    raw_ptr[1] = 2.5
    raw_ptr[2] = 3.7

    # Wrap the UnsafePointer in an ArcPointer
    var arc_ptr = ArcPointer(raw_ptr)

    # Access the memory via the original raw_ptr (or a copy) since ArcPointer doesn't expose it directly
    for i in range(3):
        print(raw_ptr[i])
    
    # ArcPointer will free the memory when it goes out of scope
    #raw_ptr.free()

fn main():
    unsafe_example()
    arcpointer_example()
    