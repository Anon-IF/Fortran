! ============================================================
! 文件名：functions.f90
! 功  能：演示子例程（subroutine）和函数（function）的定义与调用
! 对应教材：工程分析程序设计 第5章
!
! 编译命令：gfortran functions.f90 -o functions
! 运行命令：./functions
! ============================================================

program functions
  implicit none

  ! 声明外部函数的返回类型（在 contains 之外定义时需要此声明）
  real :: factorial_result
  real :: circle_area

  integer :: n
  real    :: r, a, b
  real    :: temp_a, temp_b

  ! ── 调用函数：计算阶乘 ────────────────────────────────────
  print *, "=== 阶乘计算 ==="
  n = 5
  factorial_result = factorial(n)
  print *, n, "! =", factorial_result

  ! ── 调用函数：计算圆面积 ──────────────────────────────────
  print *, ""
  print *, "=== 圆面积计算 ==="
  print *, "请输入圆的半径："
  read *, r
  circle_area = compute_area(r)
  print *, "半径为", r, "的圆面积 =", circle_area

  ! ── 调用子例程：交换两个数 ───────────────────────────────
  print *, ""
  print *, "=== 交换两个变量 ==="
  temp_a = 3.14
  temp_b = 2.71
  print *, "交换前：a =", temp_a, "，b =", temp_b
  call swap(temp_a, temp_b)   ! call 关键字用于调用 subroutine
  print *, "交换后：a =", temp_a, "，b =", temp_b

  ! ── 调用子例程：计算一元二次方程的根 ────────────────────
  print *, ""
  print *, "=== 求解方程 ax^2 + bx + c = 0 ==="
  print *, "请依次输入 a、b、c（以空格分隔）："
  read *, a, b, r    ! 这里用 r 临时存 c
  call solve_quadratic(a, b, r)

contains
  ! ============================================================
  ! 函数（function）：有返回值
  ! ── 计算 n! （阶乘）────────────────────────────────────────
  real function factorial(n)
    implicit none
    integer, intent(in) :: n     ! intent(in) 表示这是只读输入参数
    integer :: i
    factorial = 1.0
    do i = 1, n
      factorial = factorial * real(i)
    end do
  end function factorial

  ! ── 计算圆的面积 ─────────────────────────────────────────
  real function compute_area(radius)
    implicit none
    real, intent(in) :: radius
    real, parameter  :: PI = 3.14159265358979  ! parameter 定义常数
    compute_area = PI * radius * radius
  end function compute_area

  ! ============================================================
  ! 子例程（subroutine）：无返回值，通过参数传值
  ! ── 交换两个实数 ─────────────────────────────────────────
  subroutine swap(a, b)
    implicit none
    real, intent(inout) :: a, b   ! inout：可读可写
    real :: temp
    temp = a
    a    = b
    b    = temp
  end subroutine swap

  ! ── 求解一元二次方程 ax^2 + bx + c = 0 ──────────────────
  subroutine solve_quadratic(a, b, c)
    implicit none
    real, intent(in) :: a, b, c
    real :: discriminant, x1, x2

    if (abs(a) < 1.0e-10) then        ! 系数 a 接近 0，退化为一次方程
      if (abs(b) < 1.0e-10) then
        print *, "方程无解（a=0 且 b=0）"
      else
        print *, "线性方程，根为 x =", -c / b
      end if
      return
    end if

    discriminant = b * b - 4.0 * a * c   ! 判别式 Δ = b² - 4ac

    if (discriminant > 1.0e-10) then
      x1 = (-b + sqrt(discriminant)) / (2.0 * a)
      x2 = (-b - sqrt(discriminant)) / (2.0 * a)
      print *, "两个不相等实根：x1 =", x1, "，x2 =", x2
    else if (abs(discriminant) <= 1.0e-10) then   ! 用容限判断是否近似为零，避免浮点误差
      x1 = -b / (2.0 * a)
      print *, "两个相等实根（重根）：x =", x1
    else
      print *, "无实数根（判别式 < 0，有两个复数根）"
      print *, "实部 =", -b / (2.0 * a)
      print *, "虚部 = ±", sqrt(-discriminant) / (2.0 * a)
    end if
  end subroutine solve_quadratic

end program functions
