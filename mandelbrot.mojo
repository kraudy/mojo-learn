
import benchmark
from math import iota 
from sys import num_physical_cores, simdwidthof
from algorithm import parallelize, vectorize
from complex import ComplexFloat64, ComplexSIMD
from python import Python
from memory import UnsafePointer

import subprocess

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

    # This makes the struct a class
    fn __init__(out self):
        self.data = UnsafePointer[Scalar[type]].alloc(rows * cols)
    
    fn __getitem__(self, row: Int, col: Int) -> Scalar[type]:
        return self.data.load(row * cols + col)

    fn store[width: Int = 1](self, row: Int, col: Int, val: SIMD[type, width]):
        # Here we are adding elementes to the data matrix
        self.data.store(row * cols + col, val)

# Z[i + 1] = (z[i] ** 2) + c
# Number of steps to sacape
def mandelbrot_kernel(c: ComplexFloat64) -> Int:
    z = c
    for i in range(MAX_ITERS):
        z = z * z + c
        if z.squared_norm() > 4:
            return i
    return MAX_ITERS

# This returns a matrix
def compute_mandelbrot() -> Matrix[float_type, height, width]:
    # Create matrix. Each element corresponds to a pixel
    matrix = Matrix[float_type, height, width]()

    # A simple derivate
    dx = (max_x - min_x) / width
    dy = (max_y - min_y) / height

    y = min_y
    for row in range(height):
        x = min_x
        for col in range(width):
            matrix.store(row, col, mandelbrot_kernel(ComplexFloat64(x, y)))
            x += dx # Increment by the derivate
        y += dy
    return matrix

def show_plot[type: DType](matrix: Matrix[type, height, width]):
    alias scale = 10
    alias dpi = 64

    np = Python.import_module("numpy")
    plt = Python.import_module("matplotlib.pyplot")
    colors = Python.import_module("matplotlib.colors")

    numpy_array = np.zeros((height, width), np.float64)

    for row in range(height):
        for col in range(width):
            numpy_array.itemset((row, col), matrix[row, col])

    fig = plt.figure(1, [scale, scale * height // width], dpi)
    #ax = fig.add_axes([0.0, 0.0, 1.0, 1.0], False, 1)
    ax = fig.add_subplot(111, frameon=False)
    light = colors.LightSource(315, 10, 0, 1, 1, 0)

    image = light.shade(numpy_array, plt.cm.hot, colors.PowerNorm(0.3), "hsv", 0, 0, 1.5)
    plt.imshow(image)
    plt.axis("off")
    plt.show()

def main():
    show_plot(compute_mandelbrot())
