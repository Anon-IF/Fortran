! ============================================================
! 文件：module_demo.f90
! 功能：演示模块（module）的定义和使用
! 对应教材：第8章  模块与接口
! ============================================================
!
! 什么是模块？
!   模块是 Fortran 组织代码的最佳方式。它可以：
!   1. 集中存放常量和全局变量
!   2. 把相关的子程序打包在一起
!   3. 控制哪些内容对外公开（public/private）
!   4. 取代老式的 COMMON 块和 INCLUDE 文件
!
! 在实际工程项目中，不同模块通常放在不同文件中：
!   constants.f90 → module constants_mod
!   geometry.f90  → module geometry_mod
!   main.f90      → program main（use 以上模块）
!
! 为了方便演示，本文件把三个模块合并在一个文件里。
! 编译命令：gfortran module_demo.f90 -o module_demo
!
! ============================================================
! 模块1：物理和数学常量
! ============================================================
module constants_mod
  implicit none

  ! 所有内容默认公开，但良好习惯是明确声明
  real(8), parameter, public :: PI    = 3.141592653589793_8
  real(8), parameter, public :: E_NUM = 2.718281828459045_8
  real(8), parameter, public :: GRAVITY = 9.80665_8   ! 标准重力加速度 m/s^2
  real(8), parameter, public :: LIGHT_SPEED = 2.998e8_8  ! 光速 m/s

end module constants_mod

! ============================================================
! 模块2：几何计算工具
! ============================================================
module geometry_mod
  use constants_mod          ! 使用模块1中的常量
  implicit none

  private   ! 模块内所有内容默认私有
  public :: circle_area, circle_perimeter, sphere_volume  ! 明确公开这三个

contains

  ! 圆的面积
  function circle_area(r) result(area)
    real(8), intent(in) :: r
    real(8) :: area
    area = PI * r**2
  end function circle_area

  ! 圆的周长
  function circle_perimeter(r) result(peri)
    real(8), intent(in) :: r
    real(8) :: peri
    peri = 2.0_8 * PI * r
  end function circle_perimeter

  ! 球的体积
  function sphere_volume(r) result(vol)
    real(8), intent(in) :: r
    real(8) :: vol
    vol = (4.0_8 / 3.0_8) * PI * r**3
  end function sphere_volume

end module geometry_mod

! ============================================================
! 模块3：基本统计工具
! ============================================================
module stats_mod
  implicit none
  private
  public :: mean, variance, std_dev

contains

  function mean(x, n) result(m)
    integer, intent(in) :: n
    real(8), intent(in) :: x(n)
    real(8) :: m
    m = sum(x) / real(n, kind=8)
  end function mean

  function variance(x, n) result(v)
    integer, intent(in) :: n
    real(8), intent(in) :: x(n)
    real(8) :: v, m
    m = mean(x, n)
    v = sum((x - m)**2) / real(n - 1, kind=8)
  end function variance

  function std_dev(x, n) result(s)
    integer, intent(in) :: n
    real(8), intent(in) :: x(n)
    real(8) :: s
    s = sqrt(variance(x, n))
  end function std_dev

end module stats_mod

! ============================================================
! 主程序：使用上面的三个模块
! ============================================================
program module_demo
  use constants_mod   ! 使用常量模块
  use geometry_mod    ! 使用几何模块
  use stats_mod       ! 使用统计模块
  implicit none

  real(8) :: r
  real(8) :: data(6)

  ! ===== 使用常量模块 =====
  print *, "====== 物理常量 ======"
  print *, "PI           =", PI
  print *, "自然常数 e   =", E_NUM
  print *, "重力加速度   =", GRAVITY, "m/s^2"
  print *, "光速         =", LIGHT_SPEED, "m/s"

  ! ===== 使用几何模块 =====
  print *, "====== 几何计算 ======"
  r = 3.0_8
  print *, "半径 r =", r
  print *, "圆面积   =", circle_area(r)
  print *, "圆周长   =", circle_perimeter(r)
  print *, "球体积   =", sphere_volume(r)

  ! ===== 使用统计模块 =====
  print *, "====== 统计计算 ======"
  data = [2.0_8, 4.0_8, 4.0_8, 4.0_8, 5.0_8, 5.0_8]
  print *, "数据：", data
  print *, "均值     =", mean(data, 6)
  print *, "方差     =", variance(data, 6)
  print *, "标准差   =", std_dev(data, 6)

end program module_demo
