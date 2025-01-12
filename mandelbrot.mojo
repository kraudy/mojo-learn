
import benchmark
from math import iota 
from sys import num_physical_cores, simdwidthof
from algorithm import parallelize, vectorize
from complex import ComplexFloat64, ComplexSIMD
from python import Python

# Note how aliases can be used to define the variable type or directly
# the variable value (which i guess, implies the type)
alias float_type  = DType.float32
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
