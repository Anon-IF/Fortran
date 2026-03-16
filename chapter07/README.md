# 第 7 章：模块与接口

## 本章目标

- 理解模块（module）的用途和优势
- 使用 `public` / `private` 控制访问权限
- 在主程序中通过 `use` 引用模块
- 了解模块与独立子程序文件的组织方式

---

## 文件列表

| 文件 | 说明 |
|------|------|
| `module_demo.f90` | 三个模块（常量、几何、统计）+ 主程序 |

---

## 模块的基本结构

```fortran
module 模块名
  implicit none
  private          ! 默认所有内容私有
  public :: 公开的名称  ! 明确声明对外公开的内容

  ! 模块级常量和变量
  real(8), parameter :: PI = 3.14159265358979_8

contains
  ! 子程序和函数
  subroutine my_sub(...)
    ...
  end subroutine my_sub

end module 模块名
```

---

## 使用模块

```fortran
program main
  use 模块名              ! 使用整个模块
  use 模块名, only: PI    ! 只引入 PI（推荐）
  implicit none
  ...
end program main
```

---

## 多文件项目的编译

当模块在独立文件 `mymod.f90` 中时，编译顺序很重要——**必须先编译模块**：

```bash
# 先编译模块（生成 .mod 文件）
gfortran -c mymod.f90

# 再编译主程序，链接模块
gfortran main.f90 mymod.o -o myprogram

# 或一次性编译（gfortran 自动处理依赖顺序）
gfortran mymod.f90 main.f90 -o myprogram
```

---

## public 与 private

```fortran
module example_mod
  implicit none
  private             ! 默认全部私有

  integer, public :: counter = 0     ! 公开变量
  real(8), public, parameter :: PI = 3.14159_8  ! 公开常量

  ! 私有辅助函数（模块内部使用，外部不可见）
  real(8), private :: internal_value = 1.0_8

contains
  public subroutine increment()   ! 明确公开子程序
    counter = counter + 1
  end subroutine increment
end module example_mod
```

---

## 课后练习

1. 创建一个 `math_mod.f90` 模块，包含 `factorial` 和 `fibonacci` 两个函数，在主程序中调用它们。
2. 将第 4 章的矩阵操作封装到一个 `matrix_mod` 模块中，主程序通过 `use matrix_mod` 使用。
3. 尝试访问一个 `private` 变量，观察编译器给出的错误信息。
