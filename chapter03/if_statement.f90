! ============================================================
! 文件：if_statement.f90
! 功能：演示 if / else if / else 条件语句
! 对应教材：第3章  选择结构程序设计
! ============================================================
!
! 语法格式：
!   if (条件) then
!     ...语句...
!   else if (另一条件) then
!     ...语句...
!   else
!     ...语句...
!   end if
!
program if_statement
  implicit none

  real(8) :: score
  integer :: n

  ! ===== 示例1：成绩等级判断 =====
  print *, "请输入一个成绩（0~100）："
  read *, score

  if (score >= 90.0_8) then
    print *, "优秀（A）"
  else if (score >= 80.0_8) then
    print *, "良好（B）"
  else if (score >= 70.0_8) then
    print *, "中等（C）"
  else if (score >= 60.0_8) then
    print *, "及格（D）"
  else
    print *, "不及格（F）"
  end if

  ! ===== 示例2：单行 if（条件成立时只有一条语句可省略 then）=====
  n = 7
  if (mod(n, 2) == 0) print *, n, "是偶数"  ! 单行 if，无需 then/end if
  if (mod(n, 2) /= 0) print *, n, "是奇数"

  ! ===== 示例3：嵌套 if =====
  print *, "请再输入一个整数："
  read *, n

  if (n > 0) then
    if (mod(n, 2) == 0) then
      print *, n, "是正偶数"
    else
      print *, n, "是正奇数"
    end if
  else if (n < 0) then
    print *, n, "是负数"
  else
    print *, "输入的是零"
  end if

end program if_statement
