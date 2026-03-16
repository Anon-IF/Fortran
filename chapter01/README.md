# 第 1 章：Fortran 程序设计基础

## 本章目标

完成本章学习后，你将能够：
- 理解什么是 Fortran 程序
- 编写并运行自己的第一个 Fortran 程序
- 使用 `print` 和 `read` 进行基本的输入输出

---

## 文件列表

| 文件 | 说明 |
|------|------|
| `hello.f90` | 第一个程序：输出 Hello World |
| `basic_io.f90` | 基本键盘输入与屏幕输出 |

---

## 编译与运行方法

在终端中进入本目录（`cd chapter01`），然后：

```bash
# 编译单个文件
gfortran hello.f90 -o hello

# 运行（Linux/macOS）
./hello

# 运行（Windows）
hello.exe
```

---

## 程序的基本结构

```fortran
program 程序名
  implicit none    ! 必须加，防止变量未声明就使用

  ! 变量声明区

  ! 执行语句区

end program 程序名
```

### 关键词解释

| 关键词 | 作用 |
|--------|------|
| `program` | 标志程序开始，后跟程序名 |
| `implicit none` | 禁止隐式类型声明（**强烈建议始终加上**） |
| `end program` | 标志程序结束 |
| `!` | 注释符，其后内容被编译器忽略 |
| `print *, "..."` | 向屏幕输出，`*` 表示默认格式 |
| `read *, 变量` | 从键盘读取数据存入变量 |

---

## 课后练习

1. 修改 `hello.f90`，让程序输出你自己的名字。
2. 编写一个程序，读取两个整数，输出它们的和。
3. 尝试在没有 `implicit none` 的情况下编译，观察会发生什么。
