! ============================================================
! 文件：do_loop.f90
! 功能：演示计数 do 循环和 do while 循环
! 对应教材：第4章  循环结构程序设计
! ============================================================
!
! 两种主要循环形式：
!   1. 计数循环：do i = 起始, 终止[, 步长]  ... end do
!   2. 条件循环：do while (条件)            ... end do
!
! 循环控制语句：
!   exit  ——跳出整个循环（相当于 C 的 break）
!   cycle ——跳过本次迭代，进入下一次（相当于 C 的 continue）
!
program do_loop
  implicit none

  integer :: i, j, n
  real(8) :: s

  ! ===== 示例1：计数 do 循环（求 1+2+...+100）=====
  print *, "===== 示例1：求 1 到 100 的和 ====="
  s = 0.0_8
  do i = 1, 100
    s = s + i
  end do
  print *, "1 + 2 + ... + 100 =", int(s)  ! 应为 5050

  ! ===== 示例2：指定步长（偶数求和）=====
  print *, "===== 示例2：1到20中偶数之和 ====="
  s = 0.0_8
  do i = 2, 20, 2   ! 步长为 2
    s = s + i
  end do
  print *, "2+4+...+20 =", int(s)

  ! ===== 示例3：倒计数（步长为负）=====
  print *, "===== 示例3：倒计数 5 到 1 ====="
  do i = 5, 1, -1
    print *, i
  end do

  ! ===== 示例4：do while 循环（辗转相除求最大公约数）=====
  print *, "===== 示例4：do while — 求最大公约数 ====="
  print *, "请输入两个正整数 a 和 b："
  read *, i, j
  ! 辗转相除法（欧几里得算法）
  do while (j /= 0)
    n = mod(i, j)
    i = j
    j = n
  end do
  print *, "最大公约数 =", i

  ! ===== 示例5：exit 和 cycle =====
  print *, "===== 示例5：exit 和 cycle ====="
  do i = 1, 10
    if (i == 3) cycle   ! 跳过 3
    if (i == 7) exit    ! 到 7 时停止
    print *, "i =", i
  end do
  ! 输出：1 2 4 5 6

  ! ===== 示例6：嵌套循环（九九乘法表局部）=====
  print *, "===== 示例6：3x3 乘法表 ====="
  do i = 1, 3
    do j = 1, 3
      write(*, "(i2, ' x ', i2, ' = ', i2, 3x)", advance="no") i, j, i*j
    end do
    print *   ! 换行
  end do

end program do_loop
