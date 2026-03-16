! ============================================================
! 文件：numerical_integration.f90
! 功能：用梯形法则和辛普森法则计算定积分
! 对应教材：数值方法 / 数值积分
! ============================================================
!
! 【数值积分的意义】
!   并非所有函数的积分都有解析解（如 e^(-x^2)）。
!   数值积分通过将积分区间划分成许多小段来近似计算面积。
!
! 【方法1：梯形法则】
!   将曲线下面积近似为一系列梯形之和。
!   误差：O(h^2)，其中 h = (b-a)/n 为步长
!
! 【方法2：辛普森 1/3 法则】
!   用抛物线近似每段曲线（精度比梯形更高）。
!   误差：O(h^4)，精度更好（n 必须为偶数）
!
! 【示例】计算以下积分（均有精确解以便验证）：
!   ∫₀¹ x² dx = 1/3 ≈ 0.333333...
!   ∫₀^π sin(x) dx = 2
!   ∫₁² (1/x) dx = ln(2) ≈ 0.693147...
!
program numerical_integration
  implicit none

  real(8) :: result_trap, result_simp, exact
  integer :: n

  n = 1000   ! 分段数（越大越精确）

  ! ===== 示例1：∫₀¹ x² dx = 1/3 =====
  print *, "============================================="
  print *, "示例1：∫₀¹ x² dx"
  print *, "============================================="
  result_trap = trapezoidal(f1, 0.0_8, 1.0_8, n)
  result_simp = simpson(f1, 0.0_8, 1.0_8, n)
  exact = 1.0_8 / 3.0_8
  call print_comparison(result_trap, result_simp, exact)

  ! ===== 示例2：∫₀^π sin(x) dx = 2 =====
  print *, "============================================="
  print *, "示例2：∫₀^π sin(x) dx"
  print *, "============================================="
  result_trap = trapezoidal(f2, 0.0_8, acos(-1.0_8), n)
  result_simp = simpson(f2, 0.0_8, acos(-1.0_8), n)
  exact = 2.0_8
  call print_comparison(result_trap, result_simp, exact)

  ! ===== 示例3：∫₁² (1/x) dx = ln(2) =====
  print *, "============================================="
  print *, "示例3：∫₁² (1/x) dx = ln(2)"
  print *, "============================================="
  result_trap = trapezoidal(f3, 1.0_8, 2.0_8, n)
  result_simp = simpson(f3, 1.0_8, 2.0_8, n)
  exact = log(2.0_8)
  call print_comparison(result_trap, result_simp, exact)

  ! ===== 精度对比：不同 n 的误差 =====
  print *, "============================================="
  print *, "精度对比：n 对误差的影响（∫₀¹ x² dx）"
  print *, "============================================="
  print *, "  n       梯形误差            辛普森误差"
  ! 用固定的 n 值序列：4, 8, 16, 32, 64, 128, 256, 512, 1024
  do n = 4, 1024, 4    ! 步长固定为 4，后面选取 2 的幂次
    if (n /= 4 .and. n /= 8 .and. n /= 16 .and. n /= 32 .and. &
        n /= 64 .and. n /= 128 .and. n /= 256 .and. n /= 512 .and. n /= 1024) cycle
    result_trap = trapezoidal(f1, 0.0_8, 1.0_8, n)
    result_simp = simpson(f1, 0.0_8, 1.0_8, n)
    write(*, "(i6, 2e20.6)") n, abs(result_trap - 1.0_8/3.0_8), &
                                  abs(result_simp - 1.0_8/3.0_8)
  end do

contains

  !--------------------------------------------------------------
  ! 梯形法则
  function trapezoidal(f, a, b, n) result(integral)
    interface
      function f(x) result(y)
        real(8), intent(in) :: x
        real(8) :: y
      end function f
    end interface
    real(8), intent(in) :: a, b
    integer, intent(in) :: n
    real(8) :: integral

    real(8) :: h, s
    integer :: i
    h = (b - a) / real(n, kind=8)
    ! 梯形公式：h/2 * [f(a) + 2f(x1) + 2f(x2) + ... + 2f(x_{n-1}) + f(b)]
    s = f(a) + f(b)
    do i = 1, n - 1
      s = s + 2.0_8 * f(a + i * h)
    end do
    integral = s * h / 2.0_8
  end function trapezoidal

  !--------------------------------------------------------------
  ! 辛普森 1/3 法则（n 必须为偶数）
  function simpson(f, a, b, n) result(integral)
    interface
      function f(x) result(y)
        real(8), intent(in) :: x
        real(8) :: y
      end function f
    end interface
    real(8), intent(in) :: a, b
    integer, intent(in) :: n
    real(8) :: integral

    real(8) :: h, s
    integer :: i, m

    m = n                           ! 确保偶数
    if (mod(m, 2) /= 0) m = m + 1  ! 若奇数则加1

    h = (b - a) / real(m, kind=8)
    ! 辛普森公式：h/3 * [f(a) + 4f(x1) + 2f(x2) + 4f(x3) + ... + f(b)]
    s = f(a) + f(b)
    do i = 1, m - 1
      if (mod(i, 2) == 1) then
        s = s + 4.0_8 * f(a + i * h)   ! 奇数项系数 4
      else
        s = s + 2.0_8 * f(a + i * h)   ! 偶数项系数 2
      end if
    end do
    integral = s * h / 3.0_8
  end function simpson

  !--------------------------------------------------------------
  ! 被积函数
  function f1(x) result(y)   ! x^2
    real(8), intent(in) :: x
    real(8) :: y
    y = x**2
  end function f1

  function f2(x) result(y)   ! sin(x)
    real(8), intent(in) :: x
    real(8) :: y
    y = sin(x)
  end function f2

  function f3(x) result(y)   ! 1/x
    real(8), intent(in) :: x
    real(8) :: y
    y = 1.0_8 / x
  end function f3

  !--------------------------------------------------------------
  ! 打印比较结果
  subroutine print_comparison(trap, simp, exact)
    real(8), intent(in) :: trap, simp, exact
    print "(a, f18.12)", "精确值      =", exact
    print "(a, f18.12, a, e12.4)", "梯形法结果  =", trap, "  误差 =", abs(trap-exact)
    print "(a, f18.12, a, e12.4)", "辛普森结果  =", simp, "  误差 =", abs(simp-exact)
    print *
  end subroutine print_comparison

end program numerical_integration
