! ============================================================
! 文件名：math_module.f90
! 功  能：定义一个数学工具模块
! 对应教材：工程分析程序设计 第6章
!
! 说明：模块（module）是 Fortran 中组织代码的重要方式，
!       可以将相关的常量、变量、函数打包在一起。
!       先编译模块文件，再编译主程序文件。
!
! 编译命令：
!   gfortran -c math_module.f90     （生成 math_module.o 和 math_module.mod）
!   gfortran math_module.f90 main_program.f90 -o main_program
! ============================================================

module math_utils
  implicit none

  ! ── 公共常量 ──────────────────────────────────────────────
  real(8), parameter, public :: PI  = 3.141592653589793238_8
  real(8), parameter, public :: E   = 2.718281828459045235_8
  real(8), parameter, public :: PHI = 1.618033988749894848_8  ! 黄金比例

  ! ── 私有辅助变量（外部不可访问）──────────────────────────
  integer, private :: call_count = 0

contains

  ! ── 计算圆面积 ───────────────────────────────────────────
  real(8) function circle_area(r)
    real(8), intent(in) :: r
    circle_area = PI * r * r
    call_count  = call_count + 1   ! 记录被调用次数（私有变量）
  end function circle_area

  ! ── 计算圆周长 ───────────────────────────────────────────
  real(8) function circle_perimeter(r)
    real(8), intent(in) :: r
    circle_perimeter = 2.0_8 * PI * r
  end function circle_perimeter

  ! ── 角度转弧度 ───────────────────────────────────────────
  real(8) function deg2rad(degrees)
    real(8), intent(in) :: degrees
    deg2rad = degrees * PI / 180.0_8
  end function deg2rad

  ! ── 弧度转角度 ───────────────────────────────────────────
  real(8) function rad2deg(radians)
    real(8), intent(in) :: radians
    rad2deg = radians * 180.0_8 / PI
  end function rad2deg

  ! ── 计算两点间距离 ────────────────────────────────────────
  real(8) function distance(x1, y1, x2, y2)
    real(8), intent(in) :: x1, y1, x2, y2
    distance = sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end function distance

  ! ── 输出模块被调用次数（演示私有变量的作用）────────────
  subroutine print_call_count()
    print *, "circle_area 被调用了", call_count, "次"
  end subroutine print_call_count

end module math_utils
