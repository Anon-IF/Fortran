! 第五章示例2：函数（function）
! 对应教材《工程分析程序设计》第五章
! 知识点：function定义与调用、纯函数（pure）、递归函数
program functions
  implicit none
  real :: x, r
  integer :: n
  real(8), parameter :: PI = 3.14159265358979323846_8

  ! ---- 示例1：计算圆的面积 ----
  print *, "请输入圆的半径："
  read *, r
  print *, "圆的面积 =", circle_area(real(r, 8))
  print *, "圆的周长 =", circle_perimeter(real(r, 8))

  ! ---- 示例2：计算摄氏度转华氏度 ----
  print *, ""
  print *, "请输入摄氏温度："
  read *, x
  print *, x, "°C =", celsius_to_fahrenheit(real(x, 8)), "°F"

  ! ---- 示例3：递归计算阶乘 ----
  print *, ""
  print *, "请输入非负整数 n（计算n!）："
  read *, n
  if (n < 0) then
    print *, "错误：n不能为负数"
  else
    print *, n, "! =", factorial(n)
  end if

  ! ---- 示例4：递归计算斐波那契数列 ----
  print *, ""
  print *, "斐波那契数列前10项："
  do n = 0, 9
    write(*, "(i4)", advance="no") fibonacci(n)
  end do
  print *

contains

  ! 函数：计算圆的面积
  pure real(8) function circle_area(radius)
    real(8), intent(in) :: radius
    circle_area = PI * radius * radius
  end function circle_area

  ! 函数：计算圆的周长
  pure real(8) function circle_perimeter(radius)
    real(8), intent(in) :: radius
    circle_perimeter = 2.0_8 * PI * radius
  end function circle_perimeter

  ! 函数：摄氏转华氏
  pure real(8) function celsius_to_fahrenheit(c)
    real(8), intent(in) :: c
    celsius_to_fahrenheit = c * 9.0_8 / 5.0_8 + 32.0_8
  end function celsius_to_fahrenheit

  ! 递归函数：计算整数阶乘 n!
  ! 注意：使用 recursive 关键字声明递归函数
  recursive integer function factorial(n) result(res)
    integer, intent(in) :: n
    if (n <= 1) then
      res = 1
    else
      res = n * factorial(n - 1)
    end if
  end function factorial

  ! 递归函数：计算第n个斐波那契数（0-indexed）
  ! F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)
  recursive integer function fibonacci(n) result(res)
    integer, intent(in) :: n
    if (n <= 0) then
      res = 0
    else if (n == 1) then
      res = 1
    else
      res = fibonacci(n - 1) + fibonacci(n - 2)
    end if
  end function fibonacci

end program functions
