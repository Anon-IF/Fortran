! ============================================================
! 文件：variables.f90
! 功能：演示变量声明、赋值、常量（parameter）和隐式转换
! 对应教材：第2章  顺序结构程序设计
! ============================================================

program variables
  implicit none

  ! ---------- 常量（program 运行期间值不能改变）----------
  real(8), parameter :: PI  = 3.141592653589793_8
  real(8), parameter :: E   = 2.718281828459045_8
  integer, parameter :: MAX_SIZE = 100

  ! ---------- 普通变量 ----------
  integer :: n
  real(8) :: radius, area, circumference
  character(len=50) :: message

  ! ===== 赋值与计算 =====
  n      = 5
  radius = 3.0_8

  area          = PI * radius ** 2           ! 圆面积
  circumference = 2.0_8 * PI * radius        ! 圆周长

  message = "计算结果如下："

  print *, trim(message)
  print *, "半径        =", radius
  print *, "圆面积      =", area
  print *, "圆周长      =", circumference
  print *, "PI          =", PI
  print *, "MAX_SIZE    =", MAX_SIZE

  ! ===== 类型转换函数 =====
  print *, "====== 类型转换 ======"
  print *, "real(5)   =", real(5)        ! 整数 → 实数
  print *, "int(3.7)  =", int(3.7)       ! 实数 → 整数（截断，不四舍五入）
  print *, "nint(3.7) =", nint(3.7)      ! 实数 → 最近整数（四舍五入）
  print *, "dble(n)   =", dble(n)        ! 整数 → 双精度

  ! ===== 多重赋值（链式不支持，但可连续赋相同值）=====
  ! Fortran 不支持 a = b = c = 0 这样的链式赋值
  ! 必须分开写：
  ! a = 0; b = 0; c = 0   或换行写

end program variables
