# 第 4 章：数组

## 本章目标

- 声明和使用一维、二维数组
- 利用 Fortran 的数组整体操作（向量化）简化代码
- 掌握内置数组函数
- 使用可分配数组处理运行时大小不确定的数据

---

## 文件列表

| 文件 | 说明 |
|------|------|
| `array_basics.f90` | 数组声明、初始化、切片、基本运算 |
| `matrix_ops.f90` | 矩阵转置（`transpose`）与矩阵乘法（`matmul`）|
| `dynamic_array.f90` | 可分配数组（`allocatable`） |

---

## 数组声明

```fortran
! 一维数组（5个元素，下标 1~5）
real(8) :: a(5)
real(8), dimension(5) :: b   ! 等价写法

! 二维数组（3行4列）
real(8) :: mat(3, 4)   ! mat(行下标, 列下标)

! 可分配数组（运行时决定大小）
real(8), allocatable :: x(:)
real(8), allocatable :: M(:,:)
```

> ⚠️ **Fortran 数组下标默认从 1 开始**（不是 0！）

---

## 内置数组函数

| 函数 | 功能 |
|------|------|
| `size(a)` | 元素总数 |
| `size(a, dim)` | 指定维度的大小 |
| `shape(a)` | 各维度大小（返回数组） |
| `sum(a)` | 所有元素之和 |
| `product(a)` | 所有元素之积 |
| `maxval(a)` | 最大值 |
| `minval(a)` | 最小值 |
| `maxloc(a)` | 最大值所在下标 |
| `minloc(a)` | 最小值所在下标 |
| `matmul(A,B)` | 矩阵乘法 |
| `transpose(A)` | 矩阵转置 |
| `dot_product(a,b)` | 向量点积 |

---

## 可分配数组的生命周期

```fortran
real(8), allocatable :: x(:)

allocate(x(n))          ! 分配内存

! 使用 x ...
if (allocated(x)) then  ! 检查是否已分配
  deallocate(x)         ! 释放内存
end if
```

---

## 课后练习

1. 声明一个长度为 10 的整数数组，用 do 循环给每个元素赋值为其下标的平方，然后输出。
2. 编写程序，读取 n 个实数，计算其均值和标准差。
3. 编写程序，实现两个 3×3 矩阵的手动乘法（不使用 `matmul`），然后与 `matmul` 结果比较。
4. 使用可分配数组实现：用户输入一组数据，程序自动排序后输出。
