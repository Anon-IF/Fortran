! ============================================================
! 文件：functions.f90
! 功能：演示函数（function）的定义和调用
! 对应教材：第6章  函数与子程序
! ============================================================
!
! 子例程 vs 函数：
!   • 子例程（subroutine）：通过 call 调用，通过参数返回结果，可以返回多个值
!   • 函数（function）     ：像数学函数一样，直接返回一个值，可以在表达式中使用
!
! 函数写法：
!   function 函数名(参数列表) result(返回变量名)
!     声明
!     ...
!     返回变量名 = 计算结果
!   end function 函数名
!
program functions
  implicit none

  real(8) :: r, area_val, circ_val
  integer :: n
  real(8) :: PI

  PI = acos(-1.0_8)   ! 计算 PI = 3.14159...

  ! ===== 示例1：使用函数计算圆的面积和周长 =====
  r = 5.0_8
  area_val = circle_area(r, PI)
  circ_val = circle_circumference(r, PI)
  print *, "半径 =", r
  print *, "面积 =", area_val
  print *, "周长 =", circ_val

  ! ===== 示例2：阶乘（整数函数）=====
  do n = 0, 10
    print "(i3, a, i10)", n, "! = ", factorial(n)
  end do

  ! ===== 示例3：函数可以在表达式中直接使用 =====
  print *, "两个圆面积之和 =", circle_area(3.0_8, PI) + circle_area(4.0_8, PI)

contains

  !--------------------------------------------------------------
  ! 函数：计算圆的面积
  function circle_area(radius, pi_val) result(area)
    real(8), intent(in) :: radius, pi_val
    real(8) :: area           ! 返回值类型声明
    area = pi_val * radius**2
  end function circle_area

  !--------------------------------------------------------------
  ! 函数：计算圆的周长
  function circle_circumference(radius, pi_val) result(circ)
    real(8), intent(in) :: radius, pi_val
    real(8) :: circ
    circ = 2.0_8 * pi_val * radius
  end function circle_circumference

  !--------------------------------------------------------------
  ! 函数：计算非负整数的阶乘（递归写法）
  recursive function factorial(n) result(fact)
    integer, intent(in) :: n
    integer(8) :: fact    ! 用 64 位整数，否则超出范围
    if (n <= 1) then
      fact = 1
    else
      fact = n * factorial(n - 1)
    end if
  end function factorial

end program functions
