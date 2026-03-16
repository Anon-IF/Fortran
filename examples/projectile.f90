! ============================================================
! 文件：projectile.f90
! 功能：计算抛体运动轨迹
! 对应教材：工程力学应用 / 数组与循环综合运用
! ============================================================
!
! 【物理背景】
!   在只有重力的情况下，以初速度 v0、仰角 theta 抛出的物体：
!
!   水平位置：x(t) = v0 * cos(theta) * t
!   竖直位置：y(t) = v0 * sin(theta) * t - (1/2) * g * t^2
!   落地时间：T = 2 * v0 * sin(theta) / g
!   最大射程：R = v0^2 * sin(2*theta) / g
!   最大高度：H = (v0 * sin(theta))^2 / (2g)
!
program projectile
  implicit none

  real(8), parameter :: G = 9.80665_8      ! 重力加速度 (m/s^2)
  real(8), parameter :: PI = acos(-1.0_8)  ! π

  real(8) :: v0, theta_deg, theta_rad
  real(8) :: t_flight, range_max, height_max
  real(8) :: t_curr, dt, x, y
  integer :: steps, i

  ! ===== 读取初始条件 =====
  print *, "==============================="
  print *, "    抛体运动轨迹计算程序"
  print *, "==============================="
  print *, "请输入初速度 v0（m/s，如 20.0）："
  read *, v0
  print *, "请输入发射角度 theta（度，如 45.0）："
  read *, theta_deg

  theta_rad = theta_deg * PI / 180.0_8   ! 角度 → 弧度

  ! ===== 计算特征量 =====
  t_flight  = 2.0_8 * v0 * sin(theta_rad) / G
  range_max = v0**2 * sin(2.0_8 * theta_rad) / G
  height_max = (v0 * sin(theta_rad))**2 / (2.0_8 * G)

  print *, "------- 理论计算结果 -------"
  write(*, "(a, f8.2, a)") "初速度     v0    =", v0,    " m/s"
  write(*, "(a, f8.2, a)") "发射角度   θ     =", theta_deg, " 度"
  write(*, "(a, f8.4, a)") "飞行时间   T     =", t_flight,     " 秒"
  write(*, "(a, f8.3, a)") "最大射程   R     =", range_max,     " 米"
  write(*, "(a, f8.3, a)") "最大高度   H     =", height_max,     " 米"
  print *

  ! ===== 输出轨迹到文件（便于绘图）=====
  steps = 100       ! 将飞行时间分为 100 步
  dt    = t_flight / steps

  open(unit=10, file="trajectory.txt", status="replace", action="write")
  write(10, *) "# 抛体运动轨迹数据"
  write(10, *) "# 格式：时间(s)  水平位置(m)  竖直位置(m)"
  write(10, "(a, f6.2, a, f6.1, a)") "# v0=", v0, " m/s, theta=", theta_deg, " 度"

  print *, "时间(s)    x(m)      y(m)"
  print *, repeat("-", 35)

  do i = 0, steps
    t_curr = i * dt
    x = v0 * cos(theta_rad) * t_curr
    y = v0 * sin(theta_rad) * t_curr - 0.5_8 * G * t_curr**2

    if (y < 0.0_8) y = 0.0_8   ! 落地后不再下沉

    write(10, "(3f12.4)") t_curr, x, y

    ! 每隔10步打印一次到屏幕
    if (mod(i, 10) == 0) then
      write(*, "(f7.2, f10.3, f10.3)") t_curr, x, y
    end if
  end do

  close(10)
  print *
  print *, "完整轨迹已保存到 trajectory.txt"
  print *, "可用 gnuplot 绘图：plot 'trajectory.txt' u 2:3 w l"

  ! ===== 最优角度：45度时射程最大 =====
  print *
  print *, "===== 不同角度下的最大射程（v0=", v0, "m/s）====="
  print *, "角度(°)    射程(m)"
  do i = 10, 80, 10
    theta_rad = i * PI / 180.0_8
    range_max = v0**2 * sin(2.0_8 * theta_rad) / G
    write(*, "(i5, f12.3)") i, range_max
  end do

end program projectile
