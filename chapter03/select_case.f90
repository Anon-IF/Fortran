! ============================================================
! 文件：select_case.f90
! 功能：演示 select case 多分支选择语句
! 对应教材：第3章  选择结构程序设计
! ============================================================
!
! select case 适用于：根据一个整数/字符/逻辑值选择执行分支
! 优点：比多个 else if 更清晰，但只能用于离散值（不能是浮点数）
!
! 语法：
!   select case (表达式)
!     case (值1)
!       ...
!     case (值2:值3)   ! 范围 [值2, 值3]
!       ...
!     case default
!       ...
!   end select
!
program select_case
  implicit none

  integer :: month, days
  character(1) :: grade

  ! ===== 示例1：根据月份判断天数 =====
  print *, "请输入月份（1-12）："
  read *, month

  select case (month)
    case (1, 3, 5, 7, 8, 10, 12)   ! 多个值用逗号分隔
      days = 31
    case (4, 6, 9, 11)
      days = 30
    case (2)
      days = 28   ! 暂不考虑闰年
    case default
      days = -1
      print *, "月份输入有误！"
  end select

  if (days > 0) print *, month, "月有", days, "天"

  ! ===== 示例2：成绩字母等级 =====
  print *, "请输入成绩等级（A/B/C/D/F）："
  read *, grade

  select case (grade)
    case ('A')
      print *, "优秀：90-100 分"
    case ('B')
      print *, "良好：80-89 分"
    case ('C')
      print *, "中等：70-79 分"
    case ('D')
      print *, "及格：60-69 分"
    case ('F')
      print *, "不及格：60 分以下"
    case default
      print *, "无效的等级"
  end select

end program select_case
