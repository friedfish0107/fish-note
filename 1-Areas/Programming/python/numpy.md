# numpy教程 #python #语法

>最后更新：2025-04-22 02:35

## 基础元素：数组-ndarray

`numpy`的主要处理对象即为多维数组，其通常为一个由数字组成的表，其中的维度被称作"轴"(`axis`),每个轴的元素个数被称作"长度"(`length`)

数组的一部分重要的属性:

### `ndarray.ndim`

数组的轴数（维度）。

### `ndarray.shape`

数组的维数。这是一个整数元组，指示数组在每个维度上的大小。对于具有 n 行和 m 列的矩阵， 形状将是 （n，m）。因此形状元组的长度是轴的数量 `ndim`。

### `ndarray.size`

数组的元素总数。这等于形状元组所有元素的乘积。

### `ndarray.dtype`

一个描述数组中元素类型的对象。可以使用标准 Python 类型创建或指定 `dtype`。此外，NumPy 还提供了自己的类型。`numpy.int32`、`numpy.int16` 和 `numpy.float64` 是一些示例。

### `ndarray.itemsize`

数组中每个元素的字节大小。例如，`float 64` 类型的元素数组的 `itemsize` 为 8（=64/8），而 `complex 32` 类型的元素数组的 `itemsize` 为 4（=32/8）。它等效于 `ndarray.dtype.itemsize`。

### `ndarray.data`

缓冲区包含数组的实际元素。通常，我们不需要使用这个属性，因为我们将使用索引工具访问数组中的元素。

## 创建数组的几种方式

There are several ways to create arrays.
有几种方法可以创建数组。

For example, you can create an array from a regular Python list or tuple using the array function. The type of the resulting array is deduced from the type of the elements in the sequences.
例如，可以使用 `array` 函数从常规 Python 列表或元组创建数组。结果数组的类型是从序列中元素的类型推导出来的。

```python
import numpy as np
a = np.array([2, 3, 4])
a
array([2, 3, 4])
a.dtype
dtype('int64')
b = np.array([1.2, 3.5, 5.1])
b.dtype
dtype('float64')
```

A frequent error consists in calling array with multiple arguments, rather than providing a single sequence as an argument.
一个常见的错误是调用具有多个参数的数组 ，而不是提供单个序列作为参数。

```python
a = np.array(1, 2, 3, 4)    # WRONG
Traceback (most recent call last):
  ...
TypeError: array() takes from 1 to 2 positional arguments but 4 were given
a = np.array([1, 2, 3, 4])  # RIGHT
array transforms sequences of sequences into two-dimensional arrays, sequences of sequences of sequences into three-dimensional arrays, and so on.
array 将序列的序列转换为二维数组，将序列的序列的序列转换为三维数组，等等。

b = np.array([(1.5, 2, 3), (4, 5, 6)])
b
array([[1.5, 2. , 3. ],
       [4. , 5. , 6. ]])
```

The type of the array can also be explicitly specified at creation time:
数组的类型也可以在创建时显式指定：

```python
c = np.array([[1, 2], [3, 4]], dtype=complex)
c
array([[1.+0.j, 2.+0.j],
       [3.+0.j, 4.+0.j]])
```

Often, the elements of an array are originally unknown, but its size is known. Hence, NumPy offers several functions to create arrays with initial placeholder content. These minimize the necessity of growing arrays, an expensive operation.
通常，数组的元素最初是未知的，但其大小是已知的。因此，NumPy 提供了几个函数来创建具有初始占位符内容的数组。这些最大限度地减少了增长阵列的必要性，这是一项昂贵的操作。

The function zeros creates an array full of zeros, the function ones creates an array full of ones, and the function empty creates an array whose initial content is random and depends on the state of the memory. By default, the dtype of the created array is float64, but it can be specified via the key word argument dtype.
函数 `zeros` 创建一个全是零的数组， 1 创建一个满是 1 的数组，函数为空 创建一个数组，其初始内容是随机的，并取决于 记忆的状态。默认情况下，创建的数组的 `dtype` 为 `float64`，但它可以通过关键字参数 `dype` 指定。

```python
np.zeros((3, 4))t
array([[0., 0., 0., 0.],
       [0., 0., 0., 0.],
       [0., 0., 0., 0.]])
np.ones((2, 3, 4), dtype=np.int16)
array([[[1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]],

       [[1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]]], dtype=int16)
np.empty((2, 3)) 
array([[3.73603959e-262, 6.02658058e-154, 6.55490914e-260],  # may vary
       [5.30498948e-313, 3.14673309e-307, 1.00000000e+000]])
```

To create sequences of numbers, NumPy provides the arange function which is analogous to the Python built-in range, but returns an array.
为了创建数字序列，NumPy 提供了 `arange` 函数，它类似于 Python 内置的 `range`，但返回一个数组。

```python
np.arange(10, 30, 5)
array([10, 15, 20, 25])
np.arange(0, 2, 0.3)  # it accepts float arguments
array([0. , 0.3, 0.6, 0.9, 1.2, 1.5, 1.8])
```

When arange is used with floating point arguments, it is generally not possible to predict the number of elements obtained, due to the finite floating point precision. For this reason, it is usually better to use the function linspace that receives as an argument the number of elements that we want, instead of the step:
当 `arange` 与浮点参数一起使用时，由于浮点精度有限，通常无法预测获得的元素数量。出于这个原因，通常最好使用函数 `linspace`，它接收我们想要的元素数量作为参数，而不是步骤：

```python
from numpy import pi
np.linspace(0, 2, 9)                   # 9 numbers from 0 to 2
array([0.  , 0.25, 0.5 , 0.75, 1.  , 1.25, 1.5 , 1.75, 2.  ])
x = np.linspace(0, 2 * pi, 100)        # useful to evaluate function at lots of points
f = np.sin(x)
```

See also  另见

array, zeros, zeros_like, ones, ones_like, empty, empty_like, arange, linspace, random.Generator.random, random.Generator.normal, fromfunction, fromfile
阵列 ， 零 ， zeros_like， 一种 ， 一个像 ， 空的， empty_like， 阿兰热 ， linspace， 随机。发电机。随机 ， 随机.发电机.正常 ， 从函数 ， fromfile
