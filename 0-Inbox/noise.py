from PIL import Image
import numpy as np
import matplotlib.pyplot as plt

SIZE=512
LATTICE_SIZE=64

def _mix(h):
    h = np.bitwise_xor(h, np.right_shift(h, 30))
    h = h * np.uint64(0xBF58476D1CE4E5B9)
    h = np.bitwise_xor(h, np.right_shift(h, 27))
    h = h * np.uint64(0x94D049BB133111EB)
    h = np.bitwise_xor(h, np.right_shift(h, 31))
    return h

def hash11(x, seed=0):
    x = np.asarray(x)
    seed = np.asarray(seed)
    h = np.bitwise_xor(x.astype(np.uint64), seed.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = _mix(h)
    return h.astype(np.float64) / np.float64(0x1 << 64)

def hash21(x, y, seed=0):
    x, y = np.asarray(x), np.asarray(y)
    seed = np.asarray(seed)
    h = seed.astype(np.uint64)
    h = np.bitwise_xor(h, x.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, y.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = _mix(h)
    return h.astype(np.float64) / np.float64(0x1 << 64)

def hash22(x, y, seed=0):
    x, y = np.asarray(x), np.asarray(y)
    seed = np.asarray(seed)
    h = seed.astype(np.uint64)
    h = np.bitwise_xor(h, x.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, y.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = _mix(h)
    
    h_high = np.right_shift(h, 32).astype(np.uint32)
    h_low = (h & 0xFFFFFFFF).astype(np.uint32)
    return (h_high.astype(np.float64) / 0xFFFFFFFF,
            h_low.astype(np.float64) / 0xFFFFFFFF)

def hash31(x, y, z, seed=0):
    x, y, z = np.asarray(x), np.asarray(y), np.asarray(z)
    seed = np.asarray(seed)
    h = seed.astype(np.uint64)
    h = np.bitwise_xor(h, x.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, y.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, z.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = _mix(h)
    return h.astype(np.float64) / np.float64(0x1 << 64)

def hash32(x, y, z, seed=0):
    x, y, z = np.asarray(x), np.asarray(y), np.asarray(z)
    seed = np.asarray(seed)
    h = seed.astype(np.uint64)
    h = np.bitwise_xor(h, x.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, y.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, z.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = _mix(h)
    
    h_high = np.right_shift(h, 32).astype(np.uint32)
    h_low = (h & 0xFFFFFFFF).astype(np.uint32)
    return (h_high.astype(np.float64) / 0xFFFFFFFF,
            h_low.astype(np.float64) / 0xFFFFFFFF)

def hash33(x, y, z, seed=0):
    x, y, z = np.asarray(x), np.asarray(y), np.asarray(z)
    seed = np.asarray(seed)
    h = seed.astype(np.uint64)
    h = np.bitwise_xor(h, x.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, y.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = np.bitwise_xor(h, z.astype(np.uint64))
    h = h * np.uint64(0x9E3779B97F4A7C15)
    h = _mix(h)
    
    h1 = h.astype(np.float64) / np.float64(0x1 << 64)
    h2 = _mix(h + np.uint64(0x9E3779B97F4A7C15)).astype(np.float64) / np.float64(0x1 << 64)
    h3 = _mix(h + np.uint64(0xBF58476D1CE4E5B9)).astype(np.float64) / np.float64(0x1 << 64)
    return h1, h2, h3

def rand(n):
    n = n.astype(np.uint32)
    n = n + np.uint32(0x9E3779B9)
    n ^= np.left_shift(n, 17)
    n ^= np.right_shift(n, 13)
    n ^= np.left_shift(n, 5)
    n = n * np.uint32(0x9E3779B9)
    n ^= np.right_shift(n, 15)
    n ^= np.left_shift(n, 7)

    positive_n = (n & np.uint32(0xFFFFFFFF)).astype(np.float32)
    return (positive_n-np.float32(0x7FFFFFFF) )/ np.float32(0x7FFFFFFF)

def fade(x):
    return 6*x*x*x*x*x-15*x*x*x*x+10*x*x*x

def f(x):
    i=np.floor(x)
    dx=x-i
    left=rand(i)
    right=rand(i+1)

    c0=left*dx
    c1=right*(dx-1)

    u=fade(dx)

    return c0 * (1 - u) + c1 * u

"""
def value_noise1(x):
    left_point=x//LATTICE_SIZE
    left=rand(left_point)
    right_point=x//LATTICE_SIZE+1
    right=rand(right_point)
    t=(x-left_point*LATTICE_SIZE)/LATTICE_SIZE
    return left+fade(t)*(right-left)
"""

def show_noise2d():
    arr=np.fromfunction(f,(SIZE,SIZE))
    plt.imshow(arr,cmap ='gray',vmin=0,vmax=1)
    plt.show()

def show_noise1d():
    arr=np.fromfunction(lambda x:f(x/LATTICE_SIZE),(SIZE,))
    plt.plot(arr)
    plt.show()

show_noise1d()

