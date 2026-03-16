! ============================================================
! 文件名：numerical_integration.f90
! 功  能：数值积分演示
!         ① 梯形法（Trapezoidal Rule）
!         ② 辛普森法（Simpson's Rule）
!         计算 ∫₀¹ 4/(1+x²) dx = π ≈ 3.14159...
! 对应教材：工程分析程序设计 第8章 数值方法
!
! 编译命令：gfortran numerical_integration.f90 -o num_int
! 运行命令：./num_int
! ============================================================
!
! 数值积分原理（简单说明）：
!   对于难以解析积分的函数，可以把积分区间分成 n 个小段，
!   用各段的面积近似代替曲线下的面积。
!   段数 n 越大，近似越精确，但计算量也越大。
! ============================================================

program numerical_integration
  implicit none

  real(8), parameter :: PI_exact = 3.141592653589793238_8  ! 精确值，用于对比
  real(8) :: a, b       ! 积分区间 [a, b]
  real(8) :: result_trap, result_simp
  integer :: n          ! 分段数

  a = 0.0_8
  b = 1.0_8

  print *, "=== 数值积分：计算 ∫₀¹ 4/(1+x²) dx = π ==="
  print *, ""
  print *, "精确值 π =", PI_exact
  print *, ""
  print *, "  分段数 n  │  梯形法结果       │  误差(梯形)      │  辛普森结果      │  误差(辛普森)"
  print *, "  ---------│------------------│------------------│------------------│-----------------"

  ! 用不同的分段数测试，观察精度随 n 增大的提升
  do n = 10, 1000, 100
    result_trap = trapezoidal(a, b, n)
    result_simp = simpsons(a, b, n)
    print "(a, i6, a, f18.12, a, e16.6, a, f18.12, a, e16.6)", &
      "  ", n, "  │", result_trap, "  │", abs(result_trap - PI_exact), &
      "  │", result_simp, "  │", abs(result_simp - PI_exact)
  end do

contains

  ! ── 被积函数 f(x) = 4 / (1 + x²) ────────────────────────
  real(8) function f(x)
    real(8), intent(in) :: x
    f = 4.0_8 / (1.0_8 + x * x)
  end function f

  ! ── 梯形法 ───────────────────────────────────────────────
  ! 原理：将曲线近似为 n 段直线，每段面积 = 梯形面积
  !       ≈ (b-a)/n * [f(x0)/2 + f(x1) + f(x2) + ... + f(xn)/2]
  real(8) function trapezoidal(a, b, n)
    real(8), intent(in) :: a, b
    integer, intent(in) :: n
    real(8) :: h, total
    integer :: i
    h = (b - a) / real(n, 8)      ! 每段的宽度
    total = 0.5_8 * (f(a) + f(b)) ! 两端点各取一半
    do i = 1, n - 1
      total = total + f(a + real(i, 8) * h)
    end do
    trapezoidal = h * total
  end function trapezoidal

  ! ── 辛普森法 ─────────────────────────────────────────────
  ! 原理：用抛物线（二次曲线）近似每两段，精度比梯形法高
  !       要求 n 为偶数
  !       ≈ (b-a)/(3n) * [f(x0) + 4f(x1) + 2f(x2) + 4f(x3) + ... + f(xn)]
  real(8) function simpsons(a, b, n)
    real(8), intent(in) :: a, b
    integer, intent(in) :: n
    real(8) :: h, total
    integer :: i, n_even
    n_even = n                            ! 确保 n 为偶数
    if (mod(n_even, 2) /= 0) n_even = n_even + 1
    h = (b - a) / real(n_even, 8)
    total = f(a) + f(b)                   ! 两端点权重为 1
    do i = 1, n_even - 1
      if (mod(i, 2) == 1) then
        total = total + 4.0_8 * f(a + real(i, 8) * h)   ! 奇数位权重为 4
      else
        total = total + 2.0_8 * f(a + real(i, 8) * h)   ! 偶数位权重为 2
      end if
    end do
    simpsons = h / 3.0_8 * total
  end function simpsons

end program numerical_integration
