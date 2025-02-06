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

#TODO: Fix for n = 3 nan error
fn linspace[n: Int = 6](start: Float64, stop: Float64) -> SIMD[type, n]:
    #var result = SIMD[DType.float64, n]()
    var result = UnsafePointer[Scalar[type]].alloc(n)
    memset_zero(result, n)

    return result.load[width = n]()

fn make_moons[n: Int = 6](shuffle_data: Bool = True, noise: Float64 = 0.0, random_seed: Int = 0):
    seed(random_seed)

    var n_samples_out = n // 2
    print(n_samples_out)
    var n_samples_in = n - n_samples_out
    print(n_samples_in)


    var items = linspace[5](0, pi)


    print(items)

fn main():
    make_moons()
