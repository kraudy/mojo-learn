
from python import Python
from sys.info import simdbitwidth

struct examples:

  fn __init__(out self):
    pass
  
  fn __types(self):
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

  def __simd(self): 
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
  
  def __scalars(self):
      var x = UInt8(1) # is the same as SIMD[DType.uitnt8, 1]

      #x = "will cause an error"

      np = Python.import_module("numpy")
      arr = np.ndarray([5])
      print(arr)
      arr = "this works fine"
      print(arr)
      

def main():
    var ex = examples()
    ex.__types()
    ex.__simd()
    ex.__scalars()