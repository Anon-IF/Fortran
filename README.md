# Fortran 学习指南

> 基于《工程分析程序设计》（西安交通大学出版社）的零基础 Fortran 入门学习资源

---

## 快速开始

### 第一步：安装编译器

推荐使用免费开源的 **gfortran**（GNU Fortran）：

| 操作系统 | 安装命令 |
|----------|----------|
| Ubuntu/Debian | `sudo apt install gfortran` |
| macOS（需先装 Homebrew）| `brew install gcc` |
| Windows | 下载 [MinGW-w64](https://www.mingw-w64.org/) 或 [MSYS2](https://www.msys2.org/) |

安装后在终端输入 `gfortran --version` 验证。

### 第二步：编辑器

- **VS Code** + [Modern Fortran 插件](https://marketplace.visualstudio.com/items?itemName=fortran-lang.linter-gfortran)（推荐新手使用）
- 记事本/文本编辑器（最简单，保存时选 `.f90` 后缀）

### 第三步：编写并运行第一个程序

新建文件 `hello.f90`，写入：
```fortran
program hello
  implicit none
  print *, "你好，Fortran！"
end program hello
```

在终端编译并运行：
```bash
gfortran hello.f90 -o hello
./hello          ! Linux/macOS
hello.exe        ! Windows
```

---

## 项目结构

本项目按照《工程分析程序设计》教材章节组织，每章包含带详细注释的示例程序和 README：

```
Fortran/
├── chapter01/          第1章：程序基础与 Hello World
│   ├── hello.f90       第一个 Fortran 程序
│   ├── basic_io.f90    基本输入输出
│   └── README.md       本章说明与练习
├── chapter02/          第2章：顺序结构程序设计
│   ├── data_types.f90  六种基本数据类型
│   ├── variables.f90   变量、常量与类型转换
│   ├── operators.f90   运算符与内置数学函数
│   └── README.md
├── chapter03/          第3章/第4章：选择与循环结构
│   ├── if_statement.f90
│   ├── select_case.f90
│   ├── do_loop.f90
│   └── README.md
├── chapter04/          第5章：数组
│   ├── array_basics.f90
│   ├── matrix_ops.f90
│   ├── dynamic_array.f90
│   └── README.md
├── chapter05/          第6章：函数与子程序
│   ├── subroutines.f90
│   ├── functions.f90
│   └── README.md
├── chapter06/          第7章：文件操作与格式化 I/O
│   ├── file_io.f90
│   ├── formatted_io.f90
│   └── README.md
├── chapter07/          第8章：模块与接口
│   ├── module_demo.f90
│   └── README.md
├── examples/           工程应用综合示例
│   ├── newton_method.f90       牛顿迭代法求方程根
│   ├── gaussian_elim.f90       高斯消去法解线性方程组
│   ├── numerical_integration.f90  梯形法与辛普森积分法
│   ├── projectile.f90          抛体运动轨迹计算
│   └── README.md
└── exercises/          练习题集
    └── exercises.md
```

---

## 章节知识点速览

### 第 1 章：程序基础

| 知识点 | 示例 |
|--------|------|
| 程序结构 | `program main` ... `end program main` |
| 强制声明 | `implicit none`（**始终加上**） |
| 注释 | `! 这是注释` |
| 续行符 | 行末加 `&` 表示下行继续 |
| 屏幕输出 | `print *, "Hello"` |
| 键盘输入 | `read *, x` |

### 第 2 章：数据类型与运算

| 类型 | 关键字 | 推荐写法 |
|------|--------|----------|
| 整数 | `integer` | `integer :: n` |
| 双精度实数 | `real(8)` | `real(8) :: x`（科学计算推荐） |
| 复数 | `complex(8)` | `complex(8) :: z` |
| 逻辑值 | `logical` | `logical :: flag` |
| 字符串 | `character(len=n)` | `character(len=20) :: s` |

> ⚠️ **整数除法陷阱**：`10/3` 在 Fortran 中结果是 `3`，不是 `3.333`！  
> 写 `10.0/3` 或 `real(10)/3` 才能得到实数结果。

### 第 3–4 章：流程控制

```fortran
! 条件分支
if (x > 0) then
  print *, "正数"
else if (x < 0) then
  print *, "负数"
else
  print *, "零"
end if

! 计数循环（i 从 1 到 10，步长 1）
do i = 1, 10
  print *, i
end do

! 条件循环
do while (x > 0.0_8)
  x = x / 2.0_8
end do
```

### 第 5 章：数组

```fortran
real(8) :: a(5)           ! 一维数组，下标 1~5（Fortran 从 1 开始！）
real(8) :: mat(3, 3)      ! 二维数组（矩阵）

a = [1.0_8, 2.0_8, 3.0_8, 4.0_8, 5.0_8]  ! 整体赋值
print *, sum(a), maxval(a), minval(a)       ! 内置函数

C = matmul(A, B)    ! 矩阵乘法
AT = transpose(A)   ! 矩阵转置
```

### 第 6 章：子程序与函数

```fortran
! 子例程：通过 call 调用，可输出多个值
subroutine swap(a, b)
  real(8), intent(inout) :: a, b
  real(8) :: tmp
  tmp = a; a = b; b = tmp
end subroutine swap

! 函数：在表达式中使用，返回一个值
function area(r) result(s)
  real(8), intent(in) :: r
  real(8) :: s
  s = acos(-1.0_8) * r**2
end function area
```

### 第 7 章：文件操作

```fortran
open(unit=10, file="data.txt", status="replace", action="write")
write(10, "(i4, f10.4)") n, x
close(10)
```

### 第 8 章：模块

```fortran
module my_module
  implicit none
  real(8), parameter :: PI = 3.141592653589793_8
contains
  function circle_area(r) result(s)
    real(8), intent(in) :: r
    real(8) :: s
    s = PI * r**2
  end function circle_area
end module my_module

program main
  use my_module
  implicit none
  print *, circle_area(5.0_8)
end program main
```

---

## 学习路线建议（8 周）

```
第1周：环境搭建 → chapter01（Hello World + 基本 I/O）
第2周：chapter02（数据类型、运算符、内置函数）
第3周：chapter03（if 条件、select case、do 循环）
第4周：chapter04（一维数组、二维数组、可分配数组）
第5周：chapter05（子例程、函数、intent 属性）
第6周：chapter06（文件读写、格式化输出）
第7周：chapter07（模块设计、public/private）
第8周：examples/（综合工程项目：牛顿法、高斯消去、数值积分）
```

每学完一章，完成 `exercises/exercises.md` 中对应的练习题。

---

## 常见错误与解决方法

| 错误信息 | 原因 | 解决方法 |
|----------|------|----------|
| `Error: Symbol 'x' at (1) has no IMPLICIT type` | 变量未声明 | 加 `implicit none` 后声明变量 |
| 整数除法结果不对 | `10/3 = 3`（截断）| 改用 `10.0/3` 或 `real(10)/3` |
| 数组下标越界 | Fortran 下标从 1 开始 | 检查循环范围，使用 `gfortran -fcheck=bounds` 编译 |
| 精度丢失 | 使用了单精度 `real` | 改用 `real(8)` 并在字面量加 `_8`，如 `3.14_8` |
| 文件打不开 | 路径错误或文件不存在 | 检查文件名；用 `status="replace"` 创建新文件 |

---

## 调试技巧

```bash
# 开启所有警告（强烈推荐）
gfortran -Wall -Wextra your_program.f90 -o prog

# 开启运行时数组越界检查
gfortran -fcheck=bounds your_program.f90 -o prog

# 开启优化（用于生产计算）
gfortran -O2 your_program.f90 -o prog
```

---

## 在线资源

- [Fortran-lang 官方教程](https://fortran-lang.org/learn/) ⭐ 强烈推荐
- [OnlineGDB Fortran 在线编译器](https://www.onlinegdb.com/online_fortran_compiler)（无需安装）
- [Fortran-lang 论坛](https://fortran-lang.discourse.group/)（提问解答）

---

> 💡 **学习建议**：遇到不理解的地方，先把代码打出来运行一遍，再看结果和说明。  
> 动手实践是学习编程最有效的方法——**每章都有配套的可运行示例，请务必亲自编译运行！**
