! ============================================================
! 文件：operators.f90
! 功能：演示算术、关系、逻辑运算符及内置数学函数
! 对应教材：第2章  顺序结构程序设计
! ============================================================
!
! 运算符优先级（从高到低）：
!   1. **（幂运算）
!   2. * / （乘除）
!   3. + - （加减）
!   4. 关系运算符 == /= < > <= >=
!   5. .not.
!   6. .and.
!   7. .or.
!
program operators
  implicit none

  real(8) :: a, b
  logical :: p, q

  a = 10.0_8
  b =  3.0_8

  ! ===== 算术运算 =====
  print *, "====== 算术运算 ======"
  print *, "a + b =", a + b          ! 13.0
  print *, "a - b =", a - b          ! 7.0
  print *, "a * b =", a * b          ! 30.0
  print *, "a / b =", a / b          ! 3.333...
  print *, "a ** b =", a ** b        ! 1000.0  （幂运算）
  print *, "mod(a, b) =", mod(a, b)  ! 取余：1.0

  ! ===== 内置数学函数 =====
  print *, "====== 内置函数 ======"
  print *, "sqrt(2.0) =", sqrt(2.0_8)         ! 平方根
  print *, "abs(-5.0) =", abs(-5.0_8)          ! 绝对值
  print *, "sin(pi/6) =", sin(acos(-1.0_8)/6)  ! 正弦
  print *, "cos(0.0)  =", cos(0.0_8)           ! 余弦
  print *, "exp(1.0)  =", exp(1.0_8)           ! e^1
  print *, "log(e)    =", log(exp(1.0_8))      ! 自然对数
  print *, "log10(100)=", log10(100.0_8)       ! 以10为底的对数

  ! ===== 整数运算注意事项 =====
  print *, "====== 整数除法 ======"
  ! 注意：两个整数相除结果仍是整数（截断取整），容易出错！
  print *, "10 / 3 (整数) =", 10 / 3          ! 结果是 3，不是 3.333
  print *, "10.0 / 3 (实数) =", 10.0 / 3      ! 结果是 3.333（一个实数即可）

  ! ===== 关系运算符 =====
  print *, "====== 关系运算 ======"
  print *, "a == b :", a == b     ! .FALSE.
  print *, "a /= b :", a /= b     ! .TRUE.  (/= 表示"不等于")
  print *, "a >  b :", a >  b     ! .TRUE.
  print *, "a >= b :", a >= b     ! .TRUE.
  print *, "a <  b :", a <  b     ! .FALSE.

  ! ===== 逻辑运算 =====
  print *, "====== 逻辑运算 ======"
  p = .true.
  q = .false.
  print *, "p .and. q =", p .and. q  ! .FALSE.
  print *, "p .or.  q =", p .or.  q  ! .TRUE.
  print *, ".not. p   =", .not. p    ! .FALSE.

end program operators
