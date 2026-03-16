! 第三章示例1：条件语句 if-then-else
! 对应教材《工程分析程序设计》第三章
! 知识点：if、else if、else、end if；逻辑判断
program if_example
  implicit none
  real :: score
  real :: x, y, result
  integer :: n

  ! ---- 示例1：成绩等级判断 ----
  print *, "请输入考试成绩（0~100）："
  read *, score

  if (score >= 90.0) then
    print *, "等级：优秀（A）"
  else if (score >= 80.0) then
    print *, "等级：良好（B）"
  else if (score >= 70.0) then
    print *, "等级：中等（C）"
  else if (score >= 60.0) then
    print *, "等级：及格（D）"
  else
    print *, "等级：不及格（F）"
  end if

  ! ---- 示例2：判断正负零 ----
  print *, ""
  print *, "请输入一个实数："
  read *, x

  if (x > 0.0) then
    print *, x, "是正数"
  else if (x < 0.0) then
    print *, x, "是负数"
  else
    print *, "输入为零"
  end if

  ! ---- 示例3：判断奇偶 ----
  print *, ""
  print *, "请输入一个整数："
  read *, n

  if (mod(n, 2) == 0) then
    print *, n, "是偶数"
  else
    print *, n, "是奇数"
  end if

  ! ---- 示例4：计算两数之商（避免除以零） ----
  print *, ""
  print *, "请输入两个实数 x 和 y（计算 x/y）："
  read *, x, y

  if (abs(y) > 1.0e-10) then
    result = x / y
    print *, "x / y =", result
  else
    print *, "错误：除数接近零，无法计算！"
  end if

end program if_example
