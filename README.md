# Fortran 零基础学习指南
## ——配合《工程分析程序设计》教材

> 📌 本项目面向**计算机零基础**的初学者，系统介绍如何从零开始学习 Fortran 编程语言。
> 所有示例程序均配有详细中文注释，并与《工程分析程序设计》教材的章节对应。

---

## 🌟 写给零基础初学者

如果你**从来没有写过程序**，请先读这一部分。

### 什么是程序？

程序就是告诉计算机"先做什么、后做什么"的一系列指令。就像菜谱告诉你"先切菜、后炒菜"一样，程序告诉计算机"先计算这个、再输出那个"。

### 什么是编程语言？

计算机只懂 0 和 1，而人类用中文/英文思考。编程语言是中间的"翻译官"——你用编程语言写下指令，编译器把它翻译成计算机能懂的机器语言。

### 为什么学 Fortran？

Fortran 是历史最悠久的高级编程语言（1957 年诞生），它专门为**科学计算和工程分析**设计：
- 在气象预报、航空航天、结构力学等领域仍广泛使用
- 语法简洁，非常适合数值计算
- 数组运算特别方便，和数学公式写法接近
- 《工程分析程序设计》教材以 Fortran 为核心语言

---

## 📋 目录

1. [环境搭建](#一环境搭建零基础必读)
2. [项目结构](#二项目结构)
3. [学习路线](#三学习路线)
4. [各章学习内容](#四各章学习内容)
5. [快速参考](#五快速参考)
6. [常见错误与解决方法](#六常见错误与解决方法)
7. [推荐学习资源](#七推荐学习资源)

---

## 一、环境搭建（零基础必读）

### 第一步：安装编译器（gfortran）

编译器的作用：把你写的 Fortran 代码翻译成计算机能运行的程序。

#### Windows 用户（推荐方法）

1. 访问 [winlibs.com](https://winlibs.com/) 下载包含 gfortran 的 MinGW-w64 压缩包
2. 解压到 `C:\mingw64`（路径中不要有中文或空格）
3. 将 `C:\mingw64\bin` 添加到系统环境变量 `PATH`：
   - 右键"此电脑" → 属性 → 高级系统设置 → 环境变量
   - 在"系统变量"中找到 `Path`，点击"编辑"→"新建"
   - 输入 `C:\mingw64\bin`，一路点确定
4. 打开命令提示符（Win+R，输入 `cmd`），输入以下命令验证：
   ```
   gfortran --version
   ```
   看到版本号（如 `GNU Fortran 13.x.x`）说明安装成功 ✅

#### Linux 用户

```bash
# Ubuntu / Debian
sudo apt update && sudo apt install gfortran

# CentOS / RHEL
sudo yum install gcc-gfortran

# 验证
gfortran --version
```

#### macOS 用户

```bash
# 方法1：通过 Homebrew 安装（推荐）
brew install gcc

# 方法2：直接安装 Command Line Tools（包含 gfortran）
xcode-select --install

# 验证
gfortran --version
```

---

### 第二步：安装代码编辑器

推荐使用 **Visual Studio Code**（VS Code）：

1. 访问 [code.visualstudio.com](https://code.visualstudio.com/) 下载并安装
2. 打开 VS Code，点击左侧扩展图标（或按 `Ctrl+Shift+X`）
3. 搜索并安装 **"Modern Fortran"** 插件（提供语法高亮和代码提示）

---

### 第三步：编写并运行第一个程序

1. 创建一个文件夹，例如 `D:\fortran_learn`
2. 在 VS Code 中打开这个文件夹（文件 → 打开文件夹）
3. 新建文件 `hello.f90`，输入：
   ```fortran
   program hello
     implicit none
     print *, "Hello, Fortran!"
   end program hello
   ```
4. 打开终端（VS Code 中按 `Ctrl+反引号`，即 `` Ctrl+` ``），输入：
   ```bash
   gfortran hello.f90 -o hello
   ./hello          ! Linux/macOS
   hello.exe        ! Windows
   ```
5. 如果屏幕输出 `Hello, Fortran!`，恭喜你成功运行了第一个程序！🎉

> 💡 **文件扩展名说明**：Fortran 源代码文件的扩展名用 `.f90`（现代 Fortran），不要用 `.f`（旧式固定格式）。

---

## 二、项目结构

```
Fortran/
├── README.md                      ← 你正在看的这个文件
├── GETTING_STARTED.md             ← 详细的入门操作指南
├── EXERCISES.md                   ← 配套练习题与答案
└── examples/                      ← 示例程序（按章节组织）
    ├── 01_hello_world/
    │   └── hello.f90              ← 第一个程序
    ├── 02_variables/
    │   └── variables.f90          ← 变量与数据类型
    ├── 03_control_flow/
    │   ├── if_example.f90         ← 条件判断
    │   └── loop_example.f90       ← 循环
    ├── 04_arrays/
    │   └── arrays.f90             ← 数组操作
    ├── 05_functions/
    │   └── functions.f90          ← 函数与子例程
    ├── 06_modules/
    │   ├── math_module.f90        ← 模块定义
    │   └── main_program.f90       ← 使用模块的主程序
    ├── 07_file_io/
    │   └── file_io.f90            ← 文件读写
    └── 08_numerical_methods/
        ├── newton_method.f90      ← 牛顿迭代法
        └── numerical_integration.f90  ← 数值积分
```

---

## 三、学习路线

### 建议学习顺序（按周）

```
第 1 周：环境搭建 → 第1章：Hello World → 第2章：变量与类型
第 2 周：第3章：条件判断（if）→ 循环（do）→ 动手练习
第 3 周：第4章：数组（一维、二维）→ 矩阵运算
第 4 周：第5章：子例程与函数 → 代码复用
第 5 周：第6章：模块 → 第7章：文件读写
第 6 周：第8章：数值方法 → 综合项目
```

### 对应教材章节

| 本项目目录 | 教材章节 | 主要内容 |
|---|---|---|
| `01_hello_world` | 第1章 | 程序结构、编译运行 |
| `02_variables` | 第2章 | 数据类型、变量声明、算术运算 |
| `03_control_flow` | 第3章 | if 判断、do 循环、select case |
| `04_arrays` | 第4章 | 一维/二维数组、内置函数 |
| `05_functions` | 第5章 | 函数、子例程、参数传递 |
| `06_modules` | 第6章 | 模块化编程、封装 |
| `07_file_io` | 第7章 | 文件打开/读/写/关闭 |
| `08_numerical_methods` | 第8章 | 牛顿法、数值积分 |

---

## 四、各章学习内容

### 第1章：第一个 Fortran 程序

参考 `examples/01_hello_world/hello.f90`

```fortran
program hello          ! program 开始，hello 是程序名（自己起的）
  implicit none        ! 必须写！强制所有变量显式声明
  print *, "Hello!"   ! 向屏幕输出文字
end program hello      ! 程序结束
```

**编译与运行**：
```bash
gfortran hello.f90 -o hello    # 编译：生成可执行文件 hello
./hello                        # 运行（Linux/macOS）
hello.exe                      # 运行（Windows）
```

---

### 第2章：变量与数据类型

参考 `examples/02_variables/variables.f90`

| 类型 | 说明 | 示例 |
|------|------|------|
| `integer` | 整数 | `integer :: n = 10` |
| `real` | 单精度浮点数（约6-7位有效数字） | `real :: x = 3.14` |
| `real(8)` | 双精度浮点数（约15-16位有效数字，**推荐**） | `real(8) :: y` |
| `complex` | 复数 | `complex :: z = (1.0, 2.0)` |
| `logical` | 逻辑值（真/假） | `logical :: flag = .true.` |
| `character(len=N)` | 字符串（N个字符） | `character(len=20) :: name` |

> ⚠️ **初学者注意**：`7 / 2` 的结果是 `3`（整数除法，截断小数部分），不是 `3.5`！
> 如需保留小数，用 `7.0 / 2.0` 或 `real(7) / 2.0`。

---

### 第3章：流程控制

参考 `examples/03_control_flow/`

#### 条件判断（if）
```fortran
if (x > 0) then
  print *, "正数"
else if (x < 0) then
  print *, "负数"
else
  print *, "零"
end if
```

#### 计数循环（do）
```fortran
do i = 1, 10         ! i 从 1 到 10
  print *, i
end do

do i = 10, 1, -1    ! 倒数（步长为 -1）
  print *, i
end do
```

#### 条件循环（do while）
```fortran
do while (x > 0.0)
  x = x - 1.0
end do
```

#### 循环控制
```fortran
exit    ! 跳出整个循环（相当于其他语言的 break）
cycle   ! 跳过本次循环继续下一次（相当于其他语言的 continue）
```

---

### 第4章：数组

参考 `examples/04_arrays/arrays.f90`

> ⚠️ **Fortran 数组索引从 1 开始**（不是 0！）

```fortran
real :: a(5)            ! 声明 5 个元素的一维数组
real :: matrix(3, 3)    ! 3×3 矩阵

a(1) = 1.0             ! 第 1 个元素（注意！不是 a(0)）
a(5) = 5.0             ! 最后一个元素

! 内置数组函数
print *, size(a)        ! 元素个数：5
print *, sum(a)         ! 求和
print *, maxval(a)      ! 最大值
print *, minval(a)      ! 最小值

! 整体运算（不需要写循环！）
a = 0.0                ! 全部赋值为 0
a = a * 2.0            ! 每个元素乘以 2
```

---

### 第5章：函数与子例程

参考 `examples/05_functions/functions.f90`

#### 函数（有返回值）
```fortran
real function square(x)
  implicit none
  real, intent(in) :: x   ! intent(in)：只读参数
  square = x * x          ! 将结果赋给函数名
end function square

! 使用：
y = square(3.0)           ! y = 9.0
```

#### 子例程（无返回值，通过参数传出结果）
```fortran
subroutine swap(a, b)
  implicit none
  real, intent(inout) :: a, b   ! inout：可读可写
  real :: temp
  temp = a; a = b; b = temp
end subroutine swap

! 使用：
call swap(x, y)               ! 用 call 调用
```

#### `intent` 属性说明

| 属性 | 含义 |
|------|------|
| `intent(in)` | 只读（不能修改） |
| `intent(out)` | 只写（用于输出结果） |
| `intent(inout)` | 可读可写 |

---

### 第6章：模块化编程

参考 `examples/06_modules/`

模块（`module`）可以把相关的常量、变量、函数打包在一起，方便复用：

```fortran
! 在 math_module.f90 中定义模块
module math_utils
  implicit none
  real(8), parameter :: PI = 3.14159265358979_8
contains
  real(8) function circle_area(r)
    real(8), intent(in) :: r
    circle_area = PI * r * r
  end function circle_area
end module math_utils

! 在 main_program.f90 中使用模块
program main
  use math_utils        ! 导入模块
  implicit none
  print *, circle_area(5.0_8)
end program main
```

**编译有多个文件的程序**：
```bash
# 两个文件一起编译（模块文件放前面）
gfortran math_module.f90 main_program.f90 -o main_program
```

---

### 第7章：文件读写

参考 `examples/07_file_io/file_io.f90`

```fortran
! 写文件
open(unit=10, file="data.txt", status="replace", action="write")
write(10, *) x, y          ! 写到文件（不是屏幕）
close(10)                   ! 关闭文件（重要！）

! 读文件
open(unit=11, file="data.txt", status="old", action="read")
read(11, *, iostat=ios) x  ! 读一行，ios 用于检查是否到文件末尾
if (ios /= 0) exit          ! 到末尾时退出
close(11)
```

**格式化输出**：
```fortran
write(*, "(f10.4)") x          ! 宽度10、小数4位的浮点数
write(*, "(i5, f10.3)") n, x   ! 整数 + 浮点数
write(*, "(a20, e12.4)") name, val  ! 字符串 + 科学计数法
```

---

### 第8章：数值方法

参考 `examples/08_numerical_methods/`

#### 牛顿迭代法（求方程的根）

参见 `newton_method.f90`。用于求解 f(x) = 0，迭代公式：
```
x_new = x_old - f(x_old) / f'(x_old)
```

#### 数值积分

参见 `numerical_integration.f90`。
- **梯形法**：精度 O(h²)，简单易实现
- **辛普森法**：精度 O(h⁴)，精度更高，推荐使用

---

## 五、快速参考

### 程序结构模板

```fortran
program 程序名
  implicit none                ! 必须写！
  ! 变量声明区
  integer :: i
  real(8) :: x, y

  ! 执行语句区
  ! ...

contains
  ! 子程序/函数定义区（可选）
  subroutine my_sub(...)
    ! ...
  end subroutine my_sub

end program 程序名
```

### 运算符一览

| 类型 | 运算符 | 示例 |
|------|------|------|
| 算术 | `+`、`-`、`*`、`/`、`**` | `2**3` = 8 |
| 比较 | `==`、`/=`、`<`、`>`、`<=`、`>=` | `x /= 0` |
| 逻辑 | `.and.`、`.or.`、`.not.` | `.not. flag` |
| 字符串拼接 | `//` | `"Hello" // " World"` |

### 常用内置函数

| 函数 | 功能 | 示例 |
|------|------|------|
| `abs(x)` | 绝对值 | `abs(-3.0)` = 3.0 |
| `sqrt(x)` | 平方根 | `sqrt(4.0)` = 2.0 |
| `sin(x)` | 正弦（弧度） | `sin(0.0)` = 0.0 |
| `cos(x)` | 余弦（弧度） | `cos(0.0)` = 1.0 |
| `exp(x)` | 指数 eˣ | `exp(1.0)` ≈ 2.718 |
| `log(x)` | 自然对数 | `log(exp(1.0))` = 1.0 |
| `mod(n, m)` | 取余 | `mod(7, 3)` = 1 |
| `int(x)` | 转整数 | `int(3.9)` = 3 |
| `real(n)` | 转实数 | `real(3)` = 3.0 |

---

## 六、常见错误与解决方法

| 错误信息 | 原因 | 解决方法 |
|---|---|---|
| `Error: Symbol 'x' at ... has no IMPLICIT type` | 忘写 `implicit none`，或变量未声明 | 加上 `implicit none`，并声明所有变量 |
| `integer division` 结果不对 | 两个整数相除结果仍为整数 | 改用实数：`7.0 / 2.0` 或 `real(7) / 2` |
| 数组下标越界 | 访问了 `a(0)` 或超出范围的元素 | Fortran 数组从 1 开始，检查索引范围 |
| 文件打开失败 | 文件不存在，或路径错误 | 检查文件路径；读文件用 `status="old"` |
| 编译多文件时报"找不到模块" | 模块文件未先编译 | 将模块文件放在命令行的前面先编译 |
| 结果精度不足 | 使用了 `real` 单精度 | 改用 `real(8)` 双精度 |

---

## 七、推荐学习资源

### 配套教材
- 《工程分析程序设计》（本项目的主要配套教材）

### 在线资源
- [Fortran-lang 官方入门教程](https://fortran-lang.org/learn/) ⭐ 强烈推荐（英文，配图清晰）
- [在线 Fortran 编译器](https://www.onlinegdb.com/online_fortran_compiler)（无需安装，直接在浏览器运行）
- [Compiler Explorer](https://godbolt.org/)（可以看到编译后的汇编代码）

### 参考书目
- 《Fortran 95/2003 for Scientists and Engineers》by Chapman
- 《Modern Fortran Explained》by Metcalf, Reid & Cohen

---

> 💡 **学习建议**：
> 1. **动手实践**：每学一个知识点，立刻打开编辑器输入代码并运行，不要只看不写
> 2. **多犯错**：看到错误信息不要慌，认真阅读错误提示，学着理解和解决它
> 3. **改例程**：把示例代码稍微修改一下，看看会有什么变化，这是加深理解的最好方法
> 4. **遇到问题**：先自己思考，再查资料，最后寻求帮助
