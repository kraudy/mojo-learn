"""
Simple sample generator for the mojo-grad implementation.
ref: https://github.com/scikit-learn/scikit-learn/blob/main/sklearn/datasets/_samples_generator.py#L905
"""
from tensor import Tensor
from math import cos, sin, pi
from random import random_float64, seed, random_si64
from utils.index import Index

from memory import Span, ArcPointer, UnsafePointer, memset_zero
from sys.info import simdwidthof

from python import Python, PythonObject

alias type = DType.float64
alias nelts = Int(simdwidthof[type]())

fn linspace_ptr[n: Int = 6](start: Float64, stop: Float64) -> UnsafePointer[Scalar[type]]:
    var result = UnsafePointer[Scalar[type]].alloc(n)
    memset_zero(result, n)

    var step = (stop - start) / (nelts)#Float64(n - 1)
    #result.store(result.load[width = nelts]() * step, n)
    for i in range(n // nelts):
        var res = result.offset(i * nelts).load[width = nelts]() * step
        #result[i] = start + step * Float64(i)
        print("res in for: ", res)
        result.offset(i * nelts).store(res)

    #var res = result.load[width = nelts]() * step
    #print("res: ",res)
    #result.store(res)

    #for i in range(n):
    #    result[i] = start + step * Float64(i)

    return result

fn linspace_unsafe[n: Int = 6](start: Float64, stop: Float64) -> SIMD[type, n]:
    var result = UnsafePointer[Scalar[type]].alloc(n)
    memset_zero(result, n)

    return result.load[width = n]()

fn make_moons[n: Int = 6](shuffle_data: Bool = True, noise: Float64 = 0.0, random_seed: Int = 0):
    seed(random_seed)

    var n_samples_out = n // 2
    print(n_samples_out)
    var n_samples_in = n - n_samples_out
    print(n_samples_in)


    var items = linspace_unsafe[5](0, pi)
    print(items)

    var items2 = linspace_ptr[8](0, pi)
    print(items2.load[width=8]())

    print("simd with * 2: ", nelts)


fn main():
    make_moons()
