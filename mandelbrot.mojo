
import benchmark
from math import iota 
from sys import num_physical_cores, simdwidthof
from algorithm import parallelize, vectorize
from complex import ComplexFloat64, ComplexSIMD
from python import Python

alias float_type  = DType.float32
alias int_type    = DType.int32
alias simd_width  = 2 * simdwidthof[float_type]()
alias unit        = benchmark.Unit.ms