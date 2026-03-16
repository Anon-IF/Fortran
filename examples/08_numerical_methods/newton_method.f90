! ============================================================
! 文件名：newton_method.f90
! 功  能：用牛顿迭代法（Newton-Raphson）求方程 f(x)=0 的根
!         示例：求 f(x) = x^3 - 2x - 5 的根（答案约为 2.0946）
! 对应教材：工程分析程序设计 第8章 数值方法
!
! 编译命令：gfortran newton_method.f90 -o newton_method
! 运行命令：./newton_method
! ============================================================
!
! 牛顿法原理（不懂没关系，看注释！）：
!   给定初始猜测值 x0，通过迭代公式：
!     x_new = x_old - f(x_old) / f'(x_old)
!   不断逼近方程的根，直到误差小于容限。
!   其中 f'(x) 是 f(x) 的导数。
! ============================================================

program newton_method
  implicit none

  ! 声明使用内部函数（需要在 contains 之前声明接口）
  real(8) :: x, x_new
  real(8) :: fx, fpx
  real(8), parameter :: tol = 1.0e-10_8   ! 收敛容限（误差阈值）
  integer, parameter :: max_iter = 100     ! 最大迭代次数
  integer :: iter

  ! ── 牛顿法求解 x^3 - 2x - 5 = 0 ─────────────────────────
  print *, "=== 牛顿迭代法求解 x^3 - 2x - 5 = 0 ==="
  print *, ""

  ! 初始猜测值（需要靠近真实根）
  x = 2.0_8
  print *, "初始猜测：x0 =", x
  print *, ""
  print *, "迭代过程："
  print *, "  步骤      x             f(x)          误差"
  print *, "  ----  ------------  ------------  ------------"

  do iter = 1, max_iter
    ! 计算函数值和导数值
    fx  = f(x)              ! f(x) = x^3 - 2x - 5
    fpx = df(x)             ! f'(x) = 3x^2 - 2

    if (abs(fpx) < 1.0e-15_8) then   ! 防止除以接近零的数
      print *, "错误：导数接近零，迭代失败！"
      stop
    end if

    ! 牛顿迭代公式
    x_new = x - fx / fpx

    ! 输出本次迭代信息
    print "(a, i4, a, f14.10, a, e14.6, a, e14.6)", &
      "  ", iter, "  ", x_new, "  ", fx, "  ", abs(x_new - x)

    ! 检查是否收敛
    if (abs(x_new - x) < tol) then
      x = x_new
      exit
    end if

    x = x_new
  end do

  print *, ""
  if (iter <= max_iter) then
    print *, "收敛！迭代次数 =", iter
    print *, "方程的根 x =", x
    print *, "验证：f(x) =", f(x), "（应接近 0）"
  else
    print *, "警告：超过最大迭代次数，未收敛！"
  end if

contains

  ! f(x) = x^3 - 2x - 5
  real(8) function f(x)
    real(8), intent(in) :: x
    f = x**3 - 2.0_8 * x - 5.0_8
  end function f

  ! f'(x) = 3x^2 - 2（f 的导数）
  real(8) function df(x)
    real(8), intent(in) :: x
    df = 3.0_8 * x**2 - 2.0_8
  end function df

end program newton_method
