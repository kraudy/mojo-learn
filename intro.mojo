
from python import Python

struct examples:

  fn __init__(out self):
    pass
  
  fn __types(self):
      try:
        var x = Python.evaluate('5 + 10')
        print(x)
      except e:
          print("Error ", str(e))

def main():
    var ex = examples()
    ex.__types()