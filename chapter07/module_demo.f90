! 第七章示例：模块化编程
! 对应教材《工程分析程序设计》第七章
! 知识点：module定义与use、public/private访问控制、模块变量、模块过程
!
! 编译方式（注意模块文件要先编译）：
!   gfortran math_module.f90 module_demo.f90 -o module_demo
!
! 本文件将模块内联在同一文件中演示（实际项目应分文件存放）

module constants_mod
  ! 存放常用物理和数学常量
  implicit none

  ! 用 public 表示可被外部访问（默认就是 public）
  real(8), parameter, public :: PI     = 3.14159265358979323846_8
  real(8), parameter, public :: E_MATH = 2.71828182845904523536_8
  real(8), parameter, public :: GRAVITY= 9.80665_8   ! 重力加速度 m/s²
  real(8), parameter, public :: LIGHT_SPEED = 2.99792458e8_8  ! 光速 m/s

end module constants_mod


module geometry_mod
  ! 几何计算模块
  use constants_mod
  implicit none
  private              ! 默认所有符号私有
  public :: circle_area, circle_perimeter
  public :: sphere_volume, cylinder_volume

contains

  pure real(8) function circle_area(r)
    real(8), intent(in) :: r
    circle_area = PI * r * r
  end function circle_area

  pure real(8) function circle_perimeter(r)
    real(8), intent(in) :: r
    circle_perimeter = 2.0_8 * PI * r
  end function circle_perimeter

  pure real(8) function sphere_volume(r)
    real(8), intent(in) :: r
    sphere_volume = (4.0_8 / 3.0_8) * PI * r**3
  end function sphere_volume

  pure real(8) function cylinder_volume(r, h)
    real(8), intent(in) :: r, h
    cylinder_volume = PI * r * r * h
  end function cylinder_volume

end module geometry_mod


module stats_mod
  ! 统计计算模块
  implicit none
  private
  public :: mean, variance, std_dev

contains

  ! 计算均值
  pure real(8) function mean(arr)
    real(8), intent(in) :: arr(:)
    mean = sum(arr) / real(size(arr), 8)
  end function mean

  ! 计算方差（样本方差）
  pure real(8) function variance(arr)
    real(8), intent(in) :: arr(:)
    real(8) :: m
    m = mean(arr)
    variance = sum((arr - m)**2) / real(size(arr) - 1, 8)
  end function variance

  ! 计算标准差
  pure real(8) function std_dev(arr)
    real(8), intent(in) :: arr(:)
    std_dev = sqrt(variance(arr))
  end function std_dev

end module stats_mod


! 主程序：使用以上模块
program module_demo
  use constants_mod
  use geometry_mod
  use stats_mod
  implicit none

  real(8) :: r, h
  real(8) :: data(8)

  ! ---- 使用 constants_mod ----
  print *, "=== 常量模块 ==="
  print *, "圆周率 π  =", PI
  print *, "自然底数 e =", E_MATH
  print *, "重力加速度 =", GRAVITY, "m/s²"

  ! ---- 使用 geometry_mod ----
  r = 5.0_8
  h = 10.0_8
  print *, ""
  print *, "=== 几何计算模块（半径r=5, 高h=10）==="
  print *, "圆面积     =", circle_area(r)
  print *, "圆周长     =", circle_perimeter(r)
  print *, "球体积     =", sphere_volume(r)
  print *, "圆柱体积   =", cylinder_volume(r, h)

  ! ---- 使用 stats_mod ----
  data = [2.0_8, 4.0_8, 4.0_8, 4.0_8, 5.0_8, 5.0_8, 7.0_8, 9.0_8]
  print *, ""
  print *, "=== 统计计算模块 ==="
  print *, "数据：", data
  print *, "均值       =", mean(data)
  print *, "样本方差   =", variance(data)
  print *, "标准差     =", std_dev(data)

end program module_demo
