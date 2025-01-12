
import benchmark
from math import iota 
from sys import num_physical_cores, simdwidthof
from algorithm import parallelize, vectorize
from complex import ComplexFloat64, ComplexSIMD
from python import Python
from memory import UnsafePointer

# Note how aliases can be used to define the variable type or directly
# the variable value (which i guess, implies the type)
alias float_type  = DType.float32 # DType is usually used for arrays, specially for SIMD operations
alias int_type    = DType.int32
alias simd_width  = 2 * simdwidthof[float_type]()
alias unit        = benchmark.Unit.ms

alias width     = 960
alias height    = 960
alias MAX_ITERS = 200

alias min_x = -2.0
alias max_x = 0.6
alias min_y = -1.5
alias max_y = 1.5

@value
struct Matrix[type: DType, rows: Int, cols: Int]:
    var data: UnsafePointer[Scalar[type]]

    fn __init__(out self):
        self.data = UnsafePointer[Scalar[type]].alloc(rows * cols)
    
    fn __getitem__(self, row: Int, col: Int) -> Scalar[type]:
        return self.data.load(row * cols + col)

    fn store[width: Int = 1](self, row: Int, col: Int, val: SIMD[type, width]):
        self.data.store(row * cols + col, val)