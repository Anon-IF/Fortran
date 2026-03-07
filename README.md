# Fortran 学习指南

学习Fortran辅助

---

## 一、Fortran 简介

Fortran（Formula Translation）是最早的高级编程语言之一，诞生于1957年，主要用于**科学计算、数值分析、气象预测、物理模拟**等领域。现代 Fortran（Fortran 90/95/2003/2008/2018）已支持面向对象、模块化等现代编程特性，至今仍在高性能计算（HPC）领域广泛使用。

---

## 二、学习前的准备

1. **安装编译器**
   - 推荐：[GNU Fortran（gfortran）](https://gcc.gnu.org/fortran/)，免费开源，跨平台
   - 安装方式：
     - Linux/macOS：`sudo apt install gfortran` 或 `brew install gcc`
     - Windows：通过 [MinGW-w64](https://www.mingw-w64.org/) 或 [MSYS2](https://www.msys2.org/) 安装
   - 验证安装：`gfortran --version`

2. **选择编辑器 / IDE**
   - VS Code + [Modern Fortran 插件](https://marketplace.visualstudio.com/items?itemName=fortran-lang.linter-gfortran)
   - Vim / Emacs（配合语法高亮插件）
   - Intel oneAPI（含 `ifort`，适合高性能场景）

3. **了解基本的命令行操作**（编译与运行 Fortran 程序需要终端）

---

## 三、学习步骤与内容

### 第一阶段：基础入门

#### 1. 第一个 Fortran 程序
```fortran
program hello
  implicit none
  print *, "Hello, Fortran!"
end program hello
```
编译与运行：
```bash
gfortran hello.f90 -o hello
./hello
```

#### 2. 基本语法规则
- 程序结构：`program` / `end program`
- `implicit none`（强制变量显式声明，强烈建议始终使用）
- 注释：`!` 开头
- 续行：`&` 符号
- 大小写不敏感

#### 3. 数据类型与变量声明
| 类型 | 说明 | 示例 |
|------|------|------|
| `integer` | 整数 | `integer :: n = 10` |
| `real` | 单精度浮点数 | `real :: x = 3.14` |
| `double precision` | 双精度浮点数 | `double precision :: y` |
| `complex` | 复数 | `complex :: z` |
| `logical` | 逻辑值 | `logical :: flag = .true.` |
| `character` | 字符串 | `character(len=20) :: name` |

#### 4. 运算符与表达式
- 算术运算符：`+`、`-`、`*`、`/`、`**`（幂运算）
- 关系运算符：`==`、`/=`（不等）、`<`、`>`、`<=`、`>=`
- 逻辑运算符：`.and.`、`.or.`、`.not.`

#### 5. 输入与输出
```fortran
read *, x          ! 从标准输入读取
print *, "x =", x  ! 输出到标准输出
write(*,*) "..."   ! 等价写法
```

---

### 第二阶段：流程控制

#### 6. 条件语句
```fortran
if (x > 0) then
  print *, "正数"
else if (x < 0) then
  print *, "负数"
else
  print *, "零"
end if
```

#### 7. 循环
```fortran
! do 循环
do i = 1, 10
  print *, i
end do

! do while 循环
do while (x > 0)
  x = x - 1
end do

! 退出循环
exit   ! 相当于 break
cycle  ! 相当于 continue
```

#### 8. select case 语句
```fortran
select case (n)
  case (1)
    print *, "一"
  case (2:5)
    print *, "二到五"
  case default
    print *, "其他"
end select
```

---

### 第三阶段：数组（Fortran 的核心特性）

#### 9. 数组声明与初始化
```fortran
real, dimension(5) :: a          ! 一维数组
real :: b(3, 3)                  ! 二维数组（矩阵）
integer :: c(10) = [(i, i=1,10)] ! 数组构造器
```

#### 10. 数组操作
```fortran
a(1) = 3.14          ! 索引从 1 开始
b(2, 3) = 0.0
a = 0.0              ! 整体赋值
a = a * 2            ! 逐元素运算
```

#### 11. 内置数组函数
| 函数 | 功能 |
|------|------|
| `size(a)` | 元素总数 |
| `shape(a)` | 各维度大小 |
| `sum(a)` | 求和 |
| `maxval(a)` | 最大值 |
| `minval(a)` | 最小值 |
| `matmul(a, b)` | 矩阵乘法 |
| `transpose(a)` | 矩阵转置 |

#### 12. 动态数组（可分配数组）
```fortran
real, allocatable :: arr(:)
allocate(arr(n))
! 使用 arr ...
deallocate(arr)
```

---

### 第四阶段：子程序与函数

#### 13. 子例程（subroutine）
```fortran
subroutine swap(a, b)
  implicit none
  real, intent(inout) :: a, b
  real :: temp
  temp = a; a = b; b = temp
end subroutine swap

! 调用
call swap(x, y)
```

#### 14. 函数（function）
```fortran
real function square(x)
  implicit none
  real, intent(in) :: x
  square = x * x
end function square

! 调用
result = square(3.0)
```

#### 15. `intent` 属性
| 属性 | 含义 |
|------|------|
| `intent(in)` | 只读参数 |
| `intent(out)` | 只写参数（输出） |
| `intent(inout)` | 可读写参数 |

---

### 第五阶段：模块化编程

#### 16. 模块（module）
```fortran
module math_utils
  implicit none
  real(8), parameter :: PI = 3.141592653589793238_8
contains
  real function circle_area(r)
    real, intent(in) :: r
    circle_area = PI * r * r
  end function circle_area
end module math_utils

! 使用模块
program main
  use math_utils
  implicit none
  print *, circle_area(5.0)
end program main
```

#### 17. 模块的优势
- 封装数据和过程
- 控制访问权限（`public` / `private`）
- 避免全局变量污染

---

### 第六阶段：文件操作与格式化 I/O

#### 18. 文件读写
```fortran
open(unit=10, file="data.txt", status="old", action="read")
read(10, *) x, y
close(10)

open(unit=20, file="output.txt", status="replace", action="write")
write(20, "(f10.4)") result
close(20)
```

#### 19. 格式化输出
```fortran
write(*, "(a, i5, f10.3)") "n=", n, x
! a: 字符串，i: 整数，f: 浮点数，e: 科学计数法
```

---

### 第七阶段：现代 Fortran 特性（Fortran 90/95/2003+）

#### 20. 指针（pointer）
```fortran
real, pointer :: p
real, target  :: x = 1.0
p => x
print *, p  ! 输出 1.0
```

#### 21. 派生类型（结构体）
```fortran
type :: point
  real :: x, y
end type point

type(point) :: p
p%x = 1.0
p%y = 2.0
```

#### 22. 面向对象编程（Fortran 2003+）
- 类型继承（`extends`）
- 多态（`class`）
- 类型绑定过程（type-bound procedures）

#### 23. 并行编程
- **OpenMP**：共享内存并行，使用 `!$omp parallel` 指令
- **MPI**：分布式内存并行，适合超算集群
- **Coarray Fortran**：Fortran 2008 内置并行特性

---

## 四、推荐学习资源

### 在线教程
- [Fortran-lang 官方入门教程](https://fortran-lang.org/learn/) ⭐ 强烈推荐
- [Learn Fortran（交互式）](https://www.learn-fortran.org/)
- [Tutorialspoint Fortran 教程](https://www.tutorialspoint.com/fortran/)

### 书籍
- 《Fortran 95/2003 for Scientists and Engineers》by Chapman
- 《Modern Fortran Explained》by Metcalf, Reid & Cohen
- 《Introduction to Programming with Fortran》by Chivers & Sleightholme

### 实践平台
- [Compiler Explorer（Godbolt）](https://godbolt.org/)：在线编译运行
- [OnlineGDB Fortran](https://www.onlinegdb.com/online_fortran_compiler)：在线 IDE

---

## 五、推荐学习路线总结

```
第一周：环境搭建 → Hello World → 变量与类型 → 基本 I/O
第二周：流程控制（if/do/select）→ 简单程序练习
第三周：数组（一维、二维）→ 矩阵运算
第四周：子例程与函数 → 代码模块化
第五周：模块 → 文件操作 → 格式化输出
第六周：现代特性（动态数组、派生类型）→ 综合项目
进阶：OpenMP 并行 → MPI → 面向对象 → 性能优化
```

---

## 六、练习项目建议

1. **数值计算**：实现牛顿法求方程根、数值积分（梯形法则/辛普森法则）
2. **线性代数**：矩阵乘法、高斯消元法求解线性方程组
3. **物理模拟**：简谐运动、抛体运动轨迹计算
4. **数据处理**：读取 CSV 文件并计算统计量（均值、标准差）
5. **经典算法**：排序算法（冒泡、快速排序）的 Fortran 实现

---

> 💡 **学习建议**：Fortran 重在实践。建议每学一个知识点就立即编写并运行相应代码，通过动手来加深理解。遇到问题可参考 [Fortran-lang Discourse 论坛](https://fortran-lang.discourse.group/) 寻求帮助。
