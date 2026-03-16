! ============================================================
! 文件：newton_method.f90
! 功能：用牛顿迭代法求方程 f(x) = 0 的根
! 对应教材：数值方法章节 / 工程计算应用
! ============================================================
!
! 【牛顿迭代法原理】
!   已知方程 f(x) = 0，从初始猜测值 x0 出发，反复用：
!
!     x_(n+1) = x_n - f(x_n) / f'(x_n)
!
!   来逼近精确根，直到 |x_(n+1) - x_n| 足够小为止。
!
! 【示例1】求 x^3 - 2x - 5 = 0 的根（已知在 x=2 附近）
! 【示例2】求 cos(x) = x 的解（即 cos(x) - x = 0）
!
program newton_method
  implicit none

  real(8) :: root
  integer :: iter

  ! ===== 示例1：求 x^3 - 2x - 5 = 0 的根 =====
  print *, "========================================"
  print *, "示例1：求 x^3 - 2x - 5 = 0 的根"
  print *, "========================================"
  call newton(f1, df1, x0=2.0_8, tol=1.0e-10_8, max_iter=50, root=root, iter=iter)
  print "(a, f20.15)", "根 x =", root
  print "(a, f20.15)", "验证 f(x) =", f1(root)
  print "(a, i4)", "迭代次数 =", iter

  print *

  ! ===== 示例2：求 cos(x) = x 的解 =====
  print *, "========================================"
  print *, "示例2：求 cos(x) - x = 0 的解"
  print *, "========================================"
  call newton(f2, df2, x0=1.0_8, tol=1.0e-12_8, max_iter=50, root=root, iter=iter)
  print "(a, f20.15)", "根 x =", root
  print "(a, f20.15)", "验证：cos(x) =", cos(root)
  print "(a, i4)", "迭代次数 =", iter

contains

  !--------------------------------------------------------------
  ! 牛顿迭代法通用子例程
  !   f       : 函数 f(x)
  !   df      : f 的导数 f'(x)
  !   x0      : 初始猜测值
  !   tol     : 收敛容差（当步长 < tol 时停止）
  !   max_iter: 最大迭代次数
  !   root    : 输出：近似根
  !   iter    : 输出：实际迭代次数
  subroutine newton(f, df, x0, tol, max_iter, root, iter)
    interface
      function f(x) result(y)
        real(8), intent(in) :: x
        real(8) :: y
      end function f
      function df(x) result(y)
        real(8), intent(in) :: x
        real(8) :: y
      end function df
    end interface
    real(8), intent(in)  :: x0, tol
    integer, intent(in)  :: max_iter
    real(8), intent(out) :: root
    integer, intent(out) :: iter

    real(8) :: x_new, x_old, step
    integer :: k

    x_old = x0
    do k = 1, max_iter
      step  = f(x_old) / df(x_old)
      x_new = x_old - step

      write(*, "(a, i3, a, f18.12, a, e12.4)") &
        "  迭代", k, ": x =", x_new, "  步长 =", abs(step)

      if (abs(step) < tol) then
        root = x_new
        iter = k
        return
      end if
      x_old = x_new
    end do

    ! 达到最大迭代次数仍未收敛
    root = x_new
    iter = max_iter
    print *, "警告：达到最大迭代次数，可能未收敛！"
  end subroutine newton

  !--------------------------------------------------------------
  ! f1(x) = x^3 - 2x - 5
  function f1(x) result(y)
    real(8), intent(in) :: x
    real(8) :: y
    y = x**3 - 2.0_8*x - 5.0_8
  end function f1

  ! f1'(x) = 3x^2 - 2
  function df1(x) result(y)
    real(8), intent(in) :: x
    real(8) :: y
    y = 3.0_8*x**2 - 2.0_8
  end function df1

  !--------------------------------------------------------------
  ! f2(x) = cos(x) - x
  function f2(x) result(y)
    real(8), intent(in) :: x
    real(8) :: y
    y = cos(x) - x
  end function f2

  ! f2'(x) = -sin(x) - 1
  function df2(x) result(y)
    real(8), intent(in) :: x
    real(8) :: y
    y = -sin(x) - 1.0_8
  end function df2

end program newton_method
