! ============================================================
! 文件名：if_example.f90
! 功  能：演示 if 条件判断语句
! 对应教材：工程分析程序设计 第3章
!
! 编译命令：gfortran if_example.f90 -o if_example
! 运行命令：./if_example
! ============================================================

program if_example
  implicit none

  real :: score     ! 用于存储成绩
  real :: x         ! 用于存储一个数

  ! ── 示例1：简单 if 语句 ───────────────────────────────────
  print *, "=== 成绩判断 ==="
  print *, "请输入成绩（0-100）："
  read *, score          ! 从键盘读入成绩

  if (score >= 90.0) then
    print *, "优秀！"
  else if (score >= 75.0) then
    print *, "良好"
  else if (score >= 60.0) then
    print *, "及格"
  else
    print *, "不及格，需要努力！"
  end if

  ! ── 示例2：判断正负零 ─────────────────────────────────────
  print *, ""
  print *, "=== 正负数判断 ==="
  print *, "请输入一个数："
  read *, x

  if (x > 0.0) then
    print *, x, "是正数"
  else if (x < 0.0) then
    print *, x, "是负数"
  else
    print *, "这个数是零"
  end if

  ! ── 示例3：逻辑运算符组合 ────────────────────────────────
  print *, ""
  print *, "=== 区间判断（使用 .and. 和 .or.）==="
  if (x > -10.0 .and. x < 10.0) then
    print *, x, "在 (-10, 10) 范围内"
  else
    print *, x, "不在 (-10, 10) 范围内"
  end if

  ! .and. 相当于"且"，.or. 相当于"或"，.not. 相当于"非"

end program if_example
