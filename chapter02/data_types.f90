! 第二章示例1：数据类型与变量声明
! 对应教材《工程分析程序设计》第二章
! 知识点：整型、实型、双精度、复数、逻辑型、字符型
program data_types
  implicit none

  ! 整型变量
  integer :: i, j
  integer(kind=4) :: i4   ! 4字节整数
  integer(kind=8) :: i8   ! 8字节整数（大整数）

  ! 实型变量
  real :: x               ! 单精度（约7位有效数字）
  real(kind=4) :: r4      ! 明确指定4字节单精度
  real(kind=8) :: r8      ! 双精度（约15位有效数字）
  double precision :: dp  ! 等价于 real(kind=8)

  ! 复数型
  complex :: c1

  ! 逻辑型
  logical :: flag

  ! 字符型
  character(len=10) :: str1
  character(len=20) :: str2

  ! 常量（parameter）
  real, parameter :: PI = 3.14159265358979_4
  real(8), parameter :: PI8 = 3.14159265358979323846_8

  ! ---- 赋值演示 ----
  i = 100
  j = -50
  i4 = 2147483647        ! int4 最大值
  i8 = 9223372036854775807_8  ! int8 最大值

  x = 3.14
  r4 = 1.0e-5            ! 科学计数法
  r8 = 2.718281828459045_8   ! 双精度字面量用 _8 后缀

  c1 = (1.0, 2.0)        ! 复数：实部1, 虚部2

  flag = .true.

  str1 = "Fortran"
  str2 = "工程分析程序设计"

  ! ---- 输出结果 ----
  print *, "=== 整型 ==="
  print *, "i  =", i
  print *, "j  =", j
  print *, "i4 =", i4

  print *, "=== 实型 ==="
  print *, "x  =", x
  print *, "r4 =", r4
  print *, "r8 =", r8
  print *, "dp（未赋值，默认0）=", dp

  print *, "=== 复数 ==="
  print *, "c1 =", c1
  print *, "  实部 =", real(c1)
  print *, "  虚部 =", aimag(c1)

  print *, "=== 逻辑型 ==="
  print *, "flag =", flag

  print *, "=== 字符型 ==="
  print *, "str1 =", trim(str1)
  print *, "str2 =", trim(str2)

  print *, "=== 常量 ==="
  print *, "PI  =", PI
  print *, "PI8 =", PI8

end program data_types
