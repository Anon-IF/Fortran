! 第三章示例2：循环语句
! 对应教材《工程分析程序设计》第三章
! 知识点：do循环、do while循环、exit（退出）、cycle（跳过）
program do_example
  implicit none
  integer :: i, n, sum_val
  real :: x, product

  ! ---- 示例1：计算 1+2+...+N 的和 ----
  print *, "请输入正整数 N："
  read *, n

  sum_val = 0
  do i = 1, n
    sum_val = sum_val + i
  end do
  print *, "1 + 2 + ... +", n, "=", sum_val

  ! ---- 示例2：计算 N! 阶乘 ----
  print *, ""
  print *, "请输入整数 N（计算N!，建议N<=10）："
  read *, n

  product = 1.0
  do i = 1, n
    product = product * real(i)
  end do
  print *, n, "! =", product

  ! ---- 示例3：步长为2的循环（1,3,5,...,19） ----
  print *, ""
  print *, "100以内所有奇数："
  do i = 1, 100, 2
    write(*, "(i4)", advance="no") i
  end do
  print *   ! 换行

  ! ---- 示例4：do while 循环（辗转相除法求最大公约数） ----
  print *, ""
  print *, "请输入两个正整数求最大公约数："
  read *, i, n

  ! 辗转相除法（欧几里得算法）
  do while (n /= 0)
    sum_val = mod(i, n)
    i = n
    n = sum_val
  end do
  print *, "最大公约数 =", i

  ! ---- 示例5：exit 和 cycle 的使用 ----
  print *, ""
  print *, "1到20中，遇到3的倍数跳过，遇到15停止："
  do i = 1, 20
    if (mod(i, 15) == 0) exit   ! 遇到15的倍数退出整个循环
    if (mod(i, 3) == 0) cycle   ! 遇到3的倍数跳过当前迭代
    write(*, "(i4)", advance="no") i
  end do
  print *

end program do_example
