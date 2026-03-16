! ============================================================
! 文件名：loop_example.f90
! 功  能：演示 do 循环（计数循环与条件循环）
! 对应教材：工程分析程序设计 第3章
!
! 编译命令：gfortran loop_example.f90 -o loop_example
! 运行命令：./loop_example
! ============================================================

program loop_example
  implicit none

  integer :: i, n        ! 循环变量
  real    :: sum         ! 累加和
  real    :: x           ! 当前值

  ! ── 示例1：do 计数循环（类似其他语言的 for 循环）────────
  print *, "=== 输出 1 到 5 ==="
  do i = 1, 5            ! i 从 1 循环到 5，每次步长为 1
    print *, "i =", i
  end do

  ! ── 示例2：带步长的 do 循环 ──────────────────────────────
  print *, ""
  print *, "=== 输出 10 到 1（步长 -1，倒数）==="
  do i = 10, 1, -1       ! 步长为 -1，从 10 倒数到 1
    print *, i
  end do

  ! ── 示例3：用循环求累加和 ────────────────────────────────
  print *, ""
  print *, "=== 计算 1+2+...+100 ==="
  n   = 100
  sum = 0.0
  do i = 1, n
    sum = sum + real(i)   ! real() 将整数转换为实数
  end do
  print *, "1+2+...+100 =", sum

  ! ── 示例4：do while 条件循环 ─────────────────────────────
  print *, ""
  print *, "=== do while 演示：不断减半直到小于 0.01 ==="
  x = 1.0
  do while (x >= 0.01)   ! 当 x >= 0.01 时继续循环
    print *, "x =", x
    x = x / 2.0
  end do
  print *, "循环结束，最终 x =", x

  ! ── 示例5：使用 exit 和 cycle ────────────────────────────
  print *, ""
  print *, "=== exit（跳出循环） 和 cycle（跳过本次）演示 ==="
  print *, "输出 1-10 中的奇数，遇到 8 停止："
  do i = 1, 10
    if (i == 8) exit        ! 遇到 8 跳出整个循环（相当于 break）
    if (mod(i, 2) == 0) cycle  ! 偶数跳过（相当于 continue）
    print *, i
  end do

end program loop_example
