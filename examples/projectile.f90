! 工程示例4：简单的物理模拟——抛体运动轨迹
! 对应教材《工程分析程序设计》工程应用部分
!
! 问题：计算给定初速度和发射角度的抛体运动轨迹
! 物理公式：
!   x(t) = v0 * cos(θ) * t
!   y(t) = v0 * sin(θ) * t - 0.5 * g * t^2
!   飞行时间 T = 2 * v0 * sin(θ) / g
!   最大射程 R = v0^2 * sin(2θ) / g
!   最大高度 H = (v0 * sin(θ))^2 / (2g)
!
! 编译运行：
!   gfortran projectile.f90 -o projectile
!   ./projectile
program projectile
  implicit none
  real(8), parameter :: PI = 3.14159265358979323846_8
  real(8), parameter :: G  = 9.80665_8   ! 重力加速度 m/s²

  real(8) :: v0, angle_deg, angle_rad
  real(8) :: vx, vy0                     ! 速度分量
  real(8) :: flight_T, range_R, H_max    ! 飞行时间、射程、最大高度
  real(8) :: cur_t, dt, cur_x, cur_y
  integer :: step, total_steps

  ! ---- 输入参数 ----
  print *, "=== 抛体运动模拟 ==="
  print *, "请输入初速度 v0（m/s）："
  read *, v0
  print *, "请输入发射角度（度，0~90）："
  read *, angle_deg

  ! 角度转弧度
  angle_rad = angle_deg * PI / 180.0_8

  ! 速度分量
  vx  = v0 * cos(angle_rad)
  vy0 = v0 * sin(angle_rad)

  ! 理论计算
  flight_T = 2.0_8 * vy0 / G
  range_R  = v0**2 * sin(2.0_8 * angle_rad) / G
  H_max    = vy0**2 / (2.0_8 * G)

  print *, ""
  print *, "=== 理论计算结果 ==="
  write(*, "(a, f8.3, a)") "飞行时间：T =", flight_T, " 秒"
  write(*, "(a, f8.3, a)") "最大射程：R =", range_R, " 米"
  write(*, "(a, f8.3, a)") "最大高度：H =", H_max, " 米"
  write(*, "(a, f8.3, a, f8.3, a)") &
        "水平速度：vx =", vx, " m/s，初始竖直速度：vy0 =", vy0, " m/s"

  ! ---- 数值模拟轨迹 ----
  print *, ""
  print *, "=== 轨迹坐标（每隔T/20输出一次）==="
  print "(a16, a12, a12, a12)", "时间(s)", "x(m)", "y(m)", "速度(m/s)"
  print *, repeat("-", 50)

  dt = flight_T / 20.0_8
  total_steps = 21   ! 0到T，共21个点

  do step = 0, total_steps
    cur_t = real(step, 8) * dt
    if (cur_t > flight_T) cur_t = flight_T    ! 不超过飞行时间

    cur_x = vx * cur_t
    cur_y = vy0 * cur_t - 0.5_8 * G * cur_t**2

    ! 落地后高度置0
    if (cur_y < 0.0_8) cur_y = 0.0_8

    ! 当前速度大小
    associate(speed => sqrt(vx**2 + (vy0 - G * cur_t)**2))
      write(*, "(f8.3, f12.3, f12.3, f12.3)") cur_t, cur_x, cur_y, speed
    end associate
  end do

  print *, repeat("-", 50)
  print *, ""
  print *, "提示：将以上坐标导入绘图软件（如Python matplotlib）可绘制轨迹曲线。"

end program projectile
