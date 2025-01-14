
from python import Python
from sys.info import simdbitwidth
from testing import assert_false, assert_true

fn __types():
    try:
      # Note how this is using the heap
      var x = Python.evaluate('5 + 10')
      print("X = ", x)

      py = Python.import_module("builtins")
      py.print("Using python print keyword")
      py.print("X type from python: ", py.type(x)) # Type of x from python
      py.print("Addres of x: ", py.id(x)) # Object address, remember that everything is an object
    except e:
        print("Error ", str(e))
    
    # This does not use the heap, it uses the stack, which is faster
    # this value can be passed directly to register without looking for a memory adress on the stack
    x = 5 + 10
    print(x)
    # With this, there is no need for garbaje collection because we are not using the heap, the stack
    # gets freed automatically
    # Having the data type explicit helps the compiler optimization
    # No need to compile to bytecode and the pass through an interpreter like Python
    # The data can be packed into a vector, SIMD?

def __simd(): 
    y = SIMD[DType.uint8, 4](1, 2, 3, 4)
    print(y)
    # Mojo makes distinction between parameters and arguments
    # Parameters: Must be known at compile time, definitions like SIMD[DType.uint8, 4]
    # arguments: Can be known at compile time or runtime, like (1, 2, 3, 4)

    # four 8 bit numbers packed into 32 bits
    # note this is similar to numpy vector
    y *= 10
    print(y)

    # Lets see how big the simd registers are on this machine
    # 256
    print("SIMD reg size: ", simdbitwidth())

    z = SIMD[DType.uint8, 4](1)
    print(z)

def __scalars():
    var x = UInt8(1) # is the same as SIMD[DType.uitnt8, 1]

    #x = "will cause an error"

    np = Python.import_module("numpy")
    arr = np.ndarray([5])
    print(arr)
    arr = "this works fine"
    print(arr)

def __strings():
    s = String("Mojo")
    var x = s._buffer
    # = 20 # cannot implicitly convert 'IntLiteral' value to 'List[SIMD[uint8, 1], True]'
    print(s[0]) 
    decimal = ord(s[0])
    print(decimal)
    
    var word = List[Int8]()
    word.append(78)
    word.append(79)
    word.append(0) # Null termiante string, like in C
    #print(word) error
    # This is giving an error conversion
    # I opened this issue: https://github.com/modularml/mojo/issues/3947
    #var word_str = String(word) # This should make a cpy, aka another pointer

    var literal = "This is a StringLiteral"
    print(literal)
    #literal = 20 # Conversion erro

def __bool():
    var bool: Bool = True
    print(bool == False)
    var i: Int = 2
    print(i)
    var list2 = List[Int]()
    list2.append(2)
    list2.append(4)
    list2.append(6)
    print(list2[i])
    var float: FloatLiteral = 33244677779764631144466467797946.334646469
    print(float)
    var f32 = Float32(float)
    print(f32)
    var list = [1, "text"] # This can be useful for the sicp stuff
    var item1 = list.get[1, StringLiteral]()
    print(item1)
    var tup = (1, "text", 3)
    var item2 = tup.get[2, Int]()
    print(item2)
    var original = String("MojoDojo")
    print(original[0:4])
    var slice_expression = slice(0,4)
    print(original[slice_expression])
    
    #raise Error("error")

def exersices():
    py = Python.import_module("builtins")
    math = Python.import_module("math")
    print("=" * 80)
    x = Python.evaluate("2 ** 8")
    print(x)
    print(py.type(x))
    print(py.id(x))
    # var pi = float(math.pi)
    var pi = math.pi
    print(py.type(pi))
    print(py.id(pi))
    print(pi)

    var f1 = SIMD[DType.float64, 1](2.0)
    var f2 = Float64(2.0)

    var f5 = f1 * f2
    print(f5)

    for i in range(4):
        var matrix = SIMD[DType.uint8, 4](0)
        matrix[i] = 1
        print(matrix)

def main():
    __types()
    __simd()
    __scalars()
    __strings()
    __bool()
    
    exersices()