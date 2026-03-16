# 第 3 章 / 第 4 章：流程控制（选择与循环）

## 本章目标

- 使用 `if / else if / else` 实现条件分支
- 使用 `select case` 实现多路选择
- 使用 `do` 循环和 `do while` 循环实现重复执行
- 理解 `exit`（退出循环）和 `cycle`（跳过本次）

---

## 文件列表

| 文件 | 说明 |
|------|------|
| `if_statement.f90` | if / else if / else 示例 |
| `select_case.f90` | select case 多分支选择 |
| `do_loop.f90` | 计数循环、条件循环、exit/cycle |

---

## 语法速查

### if 语句

```fortran
if (条件) then
  ! 条件为真时执行
else if (另一条件) then
  ! 第二条件为真时执行
else
  ! 其余情况
end if
```

### select case 语句

```fortran
select case (整数或字符变量)
  case (值1)
    ...
  case (值2:值5)   ! 范围：值2 到 值5
    ...
  case default
    ...
end select
```

### do 计数循环

```fortran
do i = 1, 10         ! i 从 1 到 10，步长默认为 1
  print *, i
end do

do i = 10, 1, -1     ! 倒序，步长 -1
  print *, i
end do
```

### do while 循环

```fortran
do while (条件为真)
  ! 循环体
end do
```

### exit 与 cycle

```fortran
do i = 1, 100
  if (i == 5) cycle   ! 跳过 i=5 的这次迭代
  if (i == 8) exit    ! 当 i=8 时退出整个循环
  print *, i
end do
```

---

## 课后练习

1. 编写程序，判断一个年份是否为闰年（能被 400 整除，或能被 4 整除但不能被 100 整除）。
2. 用 `do` 循环计算 n 的阶乘（n! = 1×2×3×…×n）。
3. 使用 `do while` 循环，让用户不断输入数字，直到输入 0 为止，最后输出所有输入数字之和。
4. 打印出 1 到 100 内所有能被 3 整除但不能被 5 整除的数（使用 `cycle`）。
