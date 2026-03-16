! ============================================================
! 文件：data_types.f90
! 功能：演示 Fortran 的六种基本数据类型
! 对应教材：第2章  顺序结构程序设计
! ============================================================
!
! 【Fortran 基本数据类型一览】
!   integer          整数         -2147483648 ~ 2147483647
!   real             单精度实数    约 7 位有效数字
!   double precision 双精度实数    约 15~16 位有效数字（推荐用于科学计算）
!   complex          复数          由实部和虚部组成
!   logical          逻辑值        .true. 或 .false.
!   character        字符串
!
program data_types
  implicit none

  ! ---------- 整数类型 ----------
  integer :: count        ! 普通整数（32位，默认）
  integer(kind=8) :: big  ! 64位整数，可存更大的数

  ! ---------- 实数类型 ----------
  real    :: x            ! 单精度（不推荐用于精确计算）
  real(8) :: y            ! 双精度，等同于 double precision
  double precision :: z   ! 与 real(8) 完全等价

  ! ---------- 复数类型 ----------
  complex :: c1           ! 单精度复数
  complex(8) :: c2        ! 双精度复数

  ! ---------- 逻辑类型 ----------
  logical :: flag

  ! ---------- 字符串类型 ----------
  character(len=30) :: greeting  ! 最大30个字符

  ! ====== 赋值 ======
  count = 42
  big   = 9876543210_8   ! 数字后缀 _8 表示使用 64 位存储

  x = 3.14               ! 单精度字面量
  y = 3.14159265358979_8 ! 双精度字面量，后缀 _8 保证精度
  z = 2.71828182845905d0 ! d0 也表示双精度（老写法，仍常见）

  c1 = (1.0, 2.0)        ! 复数 1 + 2i
  c2 = (1.0_8, -3.5_8)   ! 双精度复数 1 - 3.5i

  flag = .true.          ! 逻辑真；逻辑假写 .false.

  greeting = "欢迎学习 Fortran！"

  ! ====== 输出 ======
  print *, "=== 整数 ==="
  print *, "count =", count
  print *, "big   =", big

  print *, "=== 实数 ==="
  print *, "x (单精度) =", x
  print *, "y (双精度) =", y
  print *, "z (双精度) =", z

  print *, "=== 复数 ==="
  print *, "c1 =", c1
  print *, "c2 =", c2

  print *, "=== 逻辑 ==="
  print *, "flag =", flag

  print *, "=== 字符串 ==="
  print *, trim(greeting)  ! trim() 去掉末尾多余的空格

end program data_types
