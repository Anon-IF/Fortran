! 第二章示例2：运算符与表达式
! 对应教材《工程分析程序设计》第二章
! 知识点：算术、关系、逻辑运算符，类型转换，内置数学函数
program expressions
  implicit none

  integer :: a, b, remainder, quotient
  real :: x, y, z
  logical :: flag1, flag2

  a = 17
  b = 5

  ! ---- 算术运算 ----
  print *, "=== 算术运算 (a=17, b=5) ==="
  print *, "a + b =", a + b       ! 22
  print *, "a - b =", a - b       ! 12
  print *, "a * b =", a * b       ! 85
  print *, "a / b =", a / b       ! 3  (整数除法，截断小数部分)
  print *, "mod(a,b) =", mod(a, b) ! 2  (取余)
  print *, "a ** b =", a ** b     ! 1419857 (幂运算)

  ! 实数运算
  x = 17.0
  y = 5.0
  print *, ""
  print *, "=== 实数运算 (x=17.0, y=5.0) ==="
  print *, "x / y =", x / y      ! 3.4
  print *, "x ** 0.5 =", x ** 0.5  ! 开平方

  ! ---- 关系运算（结果为逻辑值） ----
  print *, ""
  print *, "=== 关系运算 ==="
  print *, "a == b  :", a == b    ! .false.
  print *, "a /= b  :", a /= b    ! .true.  (/= 表示不等于)
  print *, "a >  b  :", a > b     ! .true.
  print *, "a >= b  :", a >= b    ! .true.
  print *, "a <  b  :", a < b     ! .false.
  print *, "a <= b  :", a <= b    ! .false.

  ! ---- 逻辑运算 ----
  flag1 = .true.
  flag2 = .false.
  print *, ""
  print *, "=== 逻辑运算 ==="
  print *, "flag1 .and. flag2 :", flag1 .and. flag2  ! .false.
  print *, "flag1 .or.  flag2 :", flag1 .or.  flag2  ! .true.
  print *, ".not. flag1       :", .not. flag1         ! .false.

  ! ---- 类型转换 ----
  print *, ""
  print *, "=== 类型转换 ==="
  print *, "int(3.9)  =", int(3.9)    ! 截断为3（非四舍五入）
  print *, "nint(3.9) =", nint(3.9)   ! 四舍五入为4
  print *, "real(7)   =", real(7)     ! 整数转为实数 7.0
  print *, "dble(3.14)=", dble(3.14)  ! 转为双精度

  ! ---- 常用数学函数 ----
  x = 2.0
  z = -3.5
  print *, ""
  print *, "=== 数学函数 ==="
  print *, "sqrt(2.0)  =", sqrt(x)    ! 平方根
  print *, "abs(-3.5)  =", abs(z)     ! 绝对值
  print *, "exp(1.0)   =", exp(1.0)   ! e^1
  print *, "log(2.0)   =", log(x)     ! 自然对数
  print *, "log10(100) =", log10(100.0) ! 以10为底的对数
  print *, "sin(3.14)  =", sin(3.14)  ! 正弦（弧度）
  print *, "cos(3.14)  =", cos(3.14)  ! 余弦
  print *, "tan(0.785) =", tan(0.785) ! 正切
  print *, "max(3,7,2) =", max(3, 7, 2) ! 最大值
  print *, "min(3,7,2) =", min(3, 7, 2) ! 最小值

end program expressions
