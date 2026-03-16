! 工程示例1：牛顿迭代法求方程根
! 对应教材《工程分析程序设计》工程应用部分
!
! 问题：用牛顿-拉弗森方法求方程 f(x) = x^3 - 2x - 5 = 0 的根
! 迭代公式：x_{n+1} = x_n - f(x_n) / f'(x_n)
! 其中 f'(x) = 3x^2 - 2
!
! 编译运行：
!   gfortran newton_method.f90 -o newton_method
!   ./newton_method
program newton_method
  implicit none
  real(8) :: x0, x1, fx, dfx
  real(8), parameter :: TOL = 1.0e-10_8  ! 收敛容限
  integer :: iter, max_iter
  logical :: converged

  max_iter = 100
  converged = .false.

  ! 初始猜测值（需要在根附近，此例的根约为 2.0946）
  x0 = 2.0_8

  print *, "=== 牛顿迭代法求解 x^3 - 2x - 5 = 0 ==="
  print *, "初始值 x0 =", x0
  print *, "收敛容限  =", TOL
  print *, ""
  print "(a5, a20, a20, a20)", "迭代次数", "x_n", "f(x_n)", "|x_{n+1}-x_n|"
  print *, repeat("-", 70)

  do iter = 1, max_iter
    fx  = x0**3 - 2.0_8 * x0 - 5.0_8       ! f(x)
    dfx = 3.0_8 * x0**2 - 2.0_8             ! f'(x)

    ! 避免除以零（导数太小时说明可能在极值点附近，需换初值）
    if (abs(dfx) < 1.0e-15_8) then
      print *, "警告：导数接近零，迭代失败！请换一个初始值。"
      stop
    end if

    x1 = x0 - fx / dfx   ! 牛顿公式

    write(*, "(i5, 3e20.10)") iter, x0, fx, abs(x1 - x0)

    ! 检查收敛
    if (abs(x1 - x0) < TOL) then
      converged = .true.
      x0 = x1
      exit
    end if

    x0 = x1
  end do

  print *, repeat("-", 70)
  if (converged) then
    print *, ""
    print *, "迭代收敛！"
    print *, "方程的根 x =", x0
    print *, "验证 f(x) =", x0**3 - 2.0_8 * x0 - 5.0_8
  else
    print *, "达到最大迭代次数仍未收敛，请更换初始值或增大迭代次数。"
  end if

end program newton_method
