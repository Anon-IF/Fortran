! ============================================================
! 文件名：main_program.f90
! 功  能：演示如何使用 math_module 中定义的函数和常量
! 对应教材：工程分析程序设计 第6章
!
! 编译命令（两个文件一起编译）：
!   gfortran math_module.f90 main_program.f90 -o main_program
! 运行命令：./main_program
! ============================================================

program main_program
  use math_utils          ! 导入 math_utils 模块中的所有公共成员
  implicit none

  real(8) :: r, angle_deg, angle_rad
  real(8) :: x1, y1, x2, y2, dist

  ! ── 使用模块中的常量 ─────────────────────────────────────
  print *, "=== 数学常量 ==="
  print *, "圆周率 PI =", PI
  print *, "自然常数 e =", E
  print *, "黄金比例 φ =", PHI

  ! ── 使用模块中的函数 ─────────────────────────────────────
  print *, ""
  print *, "=== 圆的计算 ==="
  r = 5.0_8
  print *, "半径 r =", r
  print *, "圆面积 =", circle_area(r)
  print *, "圆周长 =", circle_perimeter(r)

  ! 再调用一次
  r = 3.0_8
  print *, "半径 r =", r
  print *, "圆面积 =", circle_area(r)

  call print_call_count()   ! 输出 circle_area 被调用了几次

  ! ── 角度与弧度转换 ────────────────────────────────────────
  print *, ""
  print *, "=== 角度与弧度转换 ==="
  angle_deg = 90.0_8
  angle_rad = deg2rad(angle_deg)
  print *, angle_deg, "度 =", angle_rad, "弧度"
  print *, "验证：sin(90°) =", sin(angle_rad)   ! 应接近 1.0

  angle_rad = PI / 6.0_8                         ! π/6 = 30°
  print *, "π/6 弧度 =", rad2deg(angle_rad), "度"

  ! ── 两点距离 ──────────────────────────────────────────────
  print *, ""
  print *, "=== 两点间距离 ==="
  x1 = 0.0_8; y1 = 0.0_8
  x2 = 3.0_8; y2 = 4.0_8
  dist = distance(x1, y1, x2, y2)
  print *, "点(", x1, ",", y1, ")到点(", x2, ",", y2, ")的距离 =", dist
  ! 3-4-5 直角三角形，结果应为 5.0

end program main_program
