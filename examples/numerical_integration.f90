! 工程示例3：数值积分（梯形法则与辛普森法则）
! 对应教材《工程分析程序设计》工程应用部分
!
! 计算定积分 ∫_a^b f(x)dx
! 演示函数：f(x) = sin(x)，区间 [0, π]
! 精确解：∫_0^π sin(x)dx = 2.0
!
! 编译运行：
!   gfortran numerical_integration.f90 -o numerical_integration
!   ./numerical_integration
program numerical_integration
  implicit none
  real(8), parameter :: PI = 3.14159265358979323846_8
  real(8) :: a, b, exact
  integer :: n
  real(8) :: trap_result, simp_result, trap_err, simp_err

  ! 积分区间和精确值
  a = 0.0_8
  b = PI
  exact = 2.0_8   ! ∫_0^π sin(x)dx 的精确值

  print *, "=== 数值积分演示 ==="
  print *, "被积函数：f(x) = sin(x)"
  write(*, "(a, f8.4, a, f8.4, a)") "积分区间：[", a, ", ", b, "]"
  print *, "精确值  ：", exact
  print *, ""
  print "(a6, a20, a20, a20, a20)", "分段数N", "梯形法结果", "梯形法误差", "辛普森法结果", "辛普森法误差"
  print *, repeat("-", 85)

  ! 依次用 n=2, 4, 8, 16, 32, 64 展示精度提升（均为偶数，满足辛普森法则要求）
  do n = 0, 6
    ! 计算 2^n：n=0->1（跳过），n=1->2, n=2->4, ..., n=6->64
    if (n == 0) cycle
    ! 使用 2**n 得到 2,4,8,16,32,64
    associate(seg => 2**n)
      trap_result = trapezoidal(a, b, seg)
      simp_result = simpsons(a, b, seg)

      trap_err = abs(trap_result - exact)
      simp_err = abs(simp_result - exact)

      write(*, "(i6, 4e20.6)") seg, trap_result, trap_err, simp_result, simp_err
    end associate
  end do

  ! 选用 n=1000 演示最终精度
  n = 1000
  trap_result = trapezoidal(a, b, n)
  simp_result = simpsons(a, b, n)
  print *, repeat("-", 85)
  print *, ""
  print *, "使用 N=1000 段时："
  print *, "梯形法结果  =", trap_result, "  误差 =", abs(trap_result - exact)
  print *, "辛普森法结果=", simp_result, "  误差 =", abs(simp_result - exact)

contains

  ! 被积函数
  pure real(8) function f(x)
    real(8), intent(in) :: x
    f = sin(x)
  end function f

  ! 梯形法则
  ! 公式：∫_a^b f(x)dx ≈ h/2 * [f(a) + 2∑f(x_i) + f(b)]，其中 h=(b-a)/n
  real(8) function trapezoidal(a, b, n)
    real(8), intent(in) :: a, b
    integer, intent(in) :: n
    real(8) :: h, total
    integer :: i
    h = (b - a) / real(n, 8)
    total = f(a) + f(b)
    do i = 1, n - 1
      total = total + 2.0_8 * f(a + real(i, 8) * h)
    end do
    trapezoidal = h / 2.0_8 * total
  end function trapezoidal

  ! 辛普森 1/3 法则（要求 n 为偶数）
  ! 公式：∫_a^b f(x)dx ≈ h/3 * [f(x0) + 4f(x1) + 2f(x2) + 4f(x3) + ... + f(xn)]
  real(8) function simpsons(a, b, n)
    real(8), intent(in) :: a, b
    integer, intent(in) :: n
    real(8) :: h, total
    integer :: i
    h = (b - a) / real(n, 8)
    total = f(a) + f(b)
    do i = 1, n - 1
      if (mod(i, 2) == 1) then
        total = total + 4.0_8 * f(a + real(i, 8) * h)  ! 奇数项系数4
      else
        total = total + 2.0_8 * f(a + real(i, 8) * h)  ! 偶数项系数2
      end if
    end do
    simpsons = h / 3.0_8 * total
  end function simpsons

end program numerical_integration
