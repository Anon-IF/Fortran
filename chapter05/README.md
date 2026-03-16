# 第 5 章：函数与子程序

## 本章目标

- 理解子例程（subroutine）和函数（function）的区别
- 编写带有 `intent` 属性的参数
- 掌握内部子程序（`contains` 块）的写法
- 了解递归函数

---

## 文件列表

| 文件 | 说明 |
|------|------|
| `subroutines.f90` | 子例程：`swap`、统计、无参子例程 |
| `functions.f90` | 函数：圆的面积、阶乘（递归） |

---

## 子例程 vs 函数

| 对比项 | 子例程（subroutine） | 函数（function） |
|--------|---------------------|-----------------|
| 调用方式 | `call 子例程名(参数)` | `变量 = 函数名(参数)` |
| 返回值 | 通过参数返回（可多个）| 返回一个值 |
| 使用场景 | 需要修改多个变量时 | 计算并返回单一结果时 |

---

## intent 属性

```fortran
subroutine example(a, b, c)
  real(8), intent(in)    :: a   ! 只读：子程序不能修改 a
  real(8), intent(out)   :: b   ! 只写：进入时视为未定义，必须赋值
  real(8), intent(inout) :: c   ! 读写：可以读取和修改 c
  ...
end subroutine example
```

> ✅ **始终为参数指定 intent 属性**，编译器会帮你检查错误。

---

## contains 块

```fortran
program main
  implicit none
  ! 主程序代码
  call my_sub()
contains
  subroutine my_sub()    ! 内部子程序，只有本程序能调用
    ...
  end subroutine my_sub
end program main
```

---

## 课后练习

1. 编写一个函数 `max3(a, b, c)`，返回三个数中的最大值。
2. 编写一个子例程 `bubble_sort(arr, n)`，实现冒泡排序。
3. 编写一个递归函数 `fibonacci(n)`，计算斐波那契数列的第 n 项。
4. 编写一个函数，接受一个数组和其长度，返回数组中所有正数的平均值（忽略负数和零）。
