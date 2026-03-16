# Fortran 学习指南

> 本项目依据《工程分析程序设计》教材内容整理，面向计算机初学者，
> 帮助读者系统掌握 Fortran 语言并应用于工程计算。

---

## 仓库结构

```
Fortran/
├── README.md              # 本学习指南
├── chapter01/             # 第一章：Fortran 简介与第一个程序
│   ├── hello.f90          # Hello World
│   └── basic_io.f90       # 基本输入输出
├── chapter02/             # 第二章：数据类型、变量与表达式
│   ├── data_types.f90     # 整型/实型/复数/逻辑/字符类型
│   └── expressions.f90    # 运算符、类型转换、数学函数
├── chapter03/             # 第三章：程序流程控制
│   ├── if_example.f90     # if-else 条件语句
│   ├── do_example.f90     # do / do while 循环
│   └── select_example.f90 # select case 多分支
├── chapter04/             # 第四章：数组
│   ├── array_basic.f90    # 一维数组基本操作
│   ├── matrix_ops.f90     # 二维数组（矩阵运算）
│   └── dynamic_array.f90  # 可分配数组（动态内存）
├── chapter05/             # 第五章：子程序与函数
│   ├── subroutines.f90    # 子例程（subroutine）与 intent
│   └── functions.f90      # 函数（function）与递归
├── chapter06/             # 第六章：文件操作与格式化 I/O
│   └── file_io.f90        # open/read/write/close 及格式符
├── chapter07/             # 第七章：模块化编程
│   └── module_demo.f90    # module 定义、use、public/private
└── examples/              # 工程应用示例
    ├── newton_method.f90      # 牛顿迭代法求方程根
    ├── gaussian_elim.f90      # 高斯消元法求解线性方程组
    ├── numerical_integration.f90  # 数值积分（梯形法 & 辛普森法）
    └── projectile.f90         # 抛体运动轨迹模拟
```

---

## 一、Fortran 简介

Fortran（**For**mula **Tran**slation）是最早的高级编程语言之一，诞生于1957年，
主要用于**科学计算、数值分析、工程仿真、气象预测**等领域。
现代 Fortran（Fortran 90/95/2003/2008/2018）已支持模块化、面向对象、并行等
现代编程特性，至今仍是高性能计算（HPC）领域的主流语言之一。

---

## 二、学习前的准备

### 1. 安装编译器

推荐：**GNU Fortran（gfortran）**，免费开源，跨平台。

| 平台 | 安装命令 |
|------|---------|
| Ubuntu/Debian | `sudo apt install gfortran` |
| macOS (Homebrew) | `brew install gcc` |
| Windows | 通过 [MSYS2](https://www.msys2.org/) 安装：`pacman -S mingw-w64-x86_64-gcc-fortran` |

验证安装：
```bash
gfortran --version
```

### 2. 编译与运行流程

```bash
# 编译：将源码 (.f90) 编译为可执行文件
gfortran hello.f90 -o hello

# 运行
./hello          # Linux/macOS
hello.exe        # Windows
```

### 3. 选择编辑器

- **VS Code** + [Modern Fortran 插件](https://marketplace.visualstudio.com/items?itemName=fortran-lang.linter-gfortran)（推荐初学者）
- Vim / Emacs（配合语法高亮插件）
- Intel oneAPI（含 `ifort`，适合高性能场景）

---

## 三、各章知识要点

### 第一章：第一个 Fortran 程序（`chapter01/`）

```fortran
program hello
  implicit none          ! 强制显式声明所有变量
  print *, "Hello, Fortran!"
end program hello
```

**核心规则：**
- 每个程序以 `program 名称` 开始，以 `end program 名称` 结束
- **始终写 `implicit none`**，防止因变量名拼写错误引发难以察觉的 bug
- 注释用 `!` 开头；跨行用 `&` 续行；大小写不敏感

---

### 第二章：数据类型与表达式（`chapter02/`）

#### 基本数据类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `integer` | 整数 | `integer :: n = 10` |
| `real` | 单精度浮点数（约7位有效数字） | `real :: x = 3.14` |
| `real(8)` 或 `double precision` | 双精度浮点数（约15位有效数字） | `real(8) :: y = 3.14_8` |
| `complex` | 复数 | `complex :: z = (1.0, 2.0)` |
| `logical` | 逻辑值 | `logical :: flag = .true.` |
| `character(len=N)` | 字符串 | `character(len=20) :: name` |

#### 运算符优先级（从高到低）
1. `**`（幂）
2. `*`、`/`（乘除）
3. `+`、`-`（加减）
4. `==`、`/=`、`<`、`>`、`<=`、`>=`（关系）
5. `.not.`（逻辑非）
6. `.and.`（逻辑与）
7. `.or.`（逻辑或）

> ⚠️ **注意**：整数除法会截断小数部分！`7 / 2 = 3`（不是 3.5）

---

### 第三章：程序流程控制（`chapter03/`）

#### if 条件语句
```fortran
if (x > 0.0) then
  print *, "正数"
else if (x < 0.0) then
  print *, "负数"
else
  print *, "零"
end if
```

#### do 循环
```fortran
! 计数循环：i 从 1 到 10，步长为 1
do i = 1, 10
  print *, i
end do

! 步长为 2（奇数序列）
do i = 1, 19, 2
  print *, i
end do

! 条件循环
do while (x > 0.0)
  x = x - 1.0
end do

! 流程控制
exit   ! 立即退出整个循环（类似 break）
cycle  ! 跳过本次迭代继续下一次（类似 continue）
```

#### select case 语句
```fortran
select case (n)
  case (1)
    print *, "一"
  case (2:5)        ! 范围匹配
    print *, "二到五"
  case (7, 9, 11)   ! 多值匹配
    print *, "7、9或11"
  case default
    print *, "其他"
end select
```

---

### 第四章：数组（`chapter04/`）

Fortran 中数组**下标从 1 开始**（与 C/Python 不同）。

```fortran
! 声明
real :: a(10)               ! 一维数组，10个元素
real :: b(3, 3)             ! 二维数组（3×3矩阵）
real, allocatable :: c(:)   ! 可分配数组

! 初始化
a = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
a = 0.0                     ! 所有元素赋值为0
a = a * 2.0                 ! 逐元素运算

! 切片
a(3:7)     ! 第3到7个元素
a(1:10:2)  ! 第1、3、5、7、9个元素（步长2）

! 动态数组
allocate(c(n))
deallocate(c)
```

**常用内置函数：**

| 函数 | 功能 |
|------|------|
| `size(a)` | 元素总数 |
| `sum(a)` | 求和 |
| `maxval(a)` / `minval(a)` | 最大/最小值 |
| `maxloc(a,1)` / `minloc(a,1)` | 最大/最小值的位置 |
| `matmul(a, b)` | 矩阵乘法 |
| `transpose(a)` | 矩阵转置 |
| `dot_product(a, b)` | 向量点积 |

---

### 第五章：子程序与函数（`chapter05/`）

#### 子例程（subroutine）—— 无返回值，用 `call` 调用
```fortran
subroutine swap(a, b)
  implicit none
  real, intent(inout) :: a, b  ! intent 声明参数用途
  real :: temp
  temp = a;  a = b;  b = temp
end subroutine swap

call swap(x, y)   ! 调用
```

#### 函数（function）—— 有返回值
```fortran
pure real function square(x)
  implicit none
  real, intent(in) :: x
  square = x * x
end function square

result = square(3.0)   ! 调用
```

#### `intent` 属性（重要！）

| 属性 | 含义 | 作用 |
|------|------|------|
| `intent(in)` | 输入参数 | 只读，不可修改 |
| `intent(out)` | 输出参数 | 进入时不保证有值，只用于输出 |
| `intent(inout)` | 双向参数 | 可读取也可修改 |

---

### 第六章：文件操作与格式化 I/O（`chapter06/`）

```fortran
! 写文件
open(unit=10, file="result.txt", status="replace", action="write")
write(10, "(i4, 2f10.4)") i, x, y
close(10)

! 读文件
open(unit=20, file="data.txt", status="old", action="read", iostat=ios)
read(20, *, iostat=ios) x, y
close(20)
```

**常用格式说明符：**

| 格式符 | 说明 | 示例 |
|--------|------|------|
| `iW` | 整数，宽度W | `i5` → `   42` |
| `fW.D` | 小数，宽度W，D位小数 | `f10.4` → `    3.1416` |
| `eW.D` | 科学计数法 | `e12.4` → `  3.1416E+00` |
| `aW` | 字符串 | `a10` → 宽度10的字符串 |

---

### 第七章：模块化编程（`chapter07/`）

```fortran
module my_module
  implicit none
  private                    ! 默认所有符号私有
  public :: my_function      ! 显式公开

  real(8), parameter :: PI = 3.14159265358979323846_8

contains

  pure real(8) function my_function(x)
    real(8), intent(in) :: x
    my_function = PI * x * x
  end function my_function

end module my_module

! 在主程序中使用
program main
  use my_module
  implicit none
  print *, my_function(5.0_8)
end program main
```

**模块的优势：**
- 将相关变量和过程封装在一起
- 用 `private`/`public` 控制访问权限
- 避免全局变量污染，提高代码可维护性

---

## 四、工程应用示例（`examples/`）

### 牛顿迭代法（`newton_method.f90`）
求解方程 $f(x) = x^3 - 2x - 5 = 0$ 的根。
迭代公式：$x_{n+1} = x_n - \dfrac{f(x_n)}{f'(x_n)}$

### 高斯消元法（`gaussian_elim.f90`）
用带部分主元选取的高斯消元法求解线性方程组 $Ax = b$。

### 数值积分（`numerical_integration.f90`）
用梯形法则和辛普森1/3法则计算 $\displaystyle\int_0^{\pi} \sin(x)\,dx = 2$，并比较精度。

### 抛体运动模拟（`projectile.f90`）
根据给定的初速度和发射角，计算并输出抛体运动轨迹坐标。

---

## 五、快速编译运行指南

```bash
# 进入对应章节目录并编译
cd chapter01
gfortran hello.f90 -o hello && ./hello

# 带优化编译（工程计算推荐）
gfortran -O2 -o newton examples/newton_method.f90 && ./newton

# 检查语法（不生成可执行文件）
gfortran -fsyntax-only program.f90
```

---

## 六、推荐学习路线

```
第1周：环境搭建 → chapter01（Hello World + 基本 I/O）
第2周：chapter02（数据类型 + 运算符 + 数学函数）
第3周：chapter03（if + do + select case）
第4周：chapter04（数组 + 矩阵运算 + 动态数组）
第5周：chapter05（子例程 + 函数 + 递归）
第6周：chapter06（文件读写 + 格式化输出）
第7周：chapter07（模块化编程）
第8周：examples/（综合工程应用练习）
进阶：OpenMP 并行 → MPI → 面向对象（Fortran 2003+）
```

---

## 七、推荐学习资源

### 教材
- 《工程分析程序设计》（本项目依据的主要教材）
- 《Fortran 95/2003 for Scientists and Engineers》by Chapman
- 《Modern Fortran Explained》by Metcalf, Reid & Cohen

### 在线资源
- [Fortran-lang 官方入门教程](https://fortran-lang.org/learn/) ⭐ 强烈推荐
- [Compiler Explorer（Godbolt）](https://godbolt.org/)：在线编译，支持多版本编译器
- [OnlineGDB Fortran](https://www.onlinegdb.com/online_fortran_compiler)：在线 IDE，无需安装

---

> 💡 **学习建议**：Fortran 重在实践。每学一个知识点就立即编写并运行 `chapter*/` 中对应的示例代码，
> 修改参数、观察输出变化，这是掌握编程语言最高效的方式。
> 遇到问题可参考 [Fortran-lang Discourse 论坛](https://fortran-lang.discourse.group/)。
