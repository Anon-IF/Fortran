! 第三章示例3：select case 多分支语句
! 对应教材《工程分析程序设计》第三章
! 知识点：select case 语句，整数、字符的多路分支
program select_example
  implicit none
  integer :: day, month
  character(len=1) :: grade
  real :: area, a, b, c
  character(len=10) :: shape

  ! ---- 示例1：星期几 ----
  print *, "请输入星期几（1=周一，7=周日）："
  read *, day

  select case (day)
    case (1)
      print *, "星期一 Monday"
    case (2)
      print *, "星期二 Tuesday"
    case (3)
      print *, "星期三 Wednesday"
    case (4)
      print *, "星期四 Thursday"
    case (5)
      print *, "星期五 Friday"
    case (6, 7)
      print *, "周末 Weekend"
    case default
      print *, "无效输入，请输入1~7"
  end select

  ! ---- 示例2：每月天数 ----
  print *, ""
  print *, "请输入月份（1~12）："
  read *, month

  select case (month)
    case (1, 3, 5, 7, 8, 10, 12)
      print *, month, "月有 31 天"
    case (4, 6, 9, 11)
      print *, month, "月有 30 天"
    case (2)
      print *, "2月有28或29天（取决于是否闰年）"
    case default
      print *, "无效月份"
  end select

  ! ---- 示例3：根据成绩字母等级给出建议 ----
  print *, ""
  print *, "请输入成绩等级（A/B/C/D/F）："
  read *, grade

  select case (grade)
    case ("A")
      print *, "优秀！继续保持！"
    case ("B")
      print *, "良好，再接再厉！"
    case ("C")
      print *, "中等，需要加强练习。"
    case ("D")
      print *, "及格，刚好通过。"
    case ("F")
      print *, "不及格，需要重修。"
    case default
      print *, "未知等级。"
  end select

end program select_example
