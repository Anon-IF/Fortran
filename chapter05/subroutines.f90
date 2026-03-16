! ============================================================
! 文件：subroutines.f90
! 功能：演示子例程（subroutine）的定义和调用
! 对应教材：第6章  函数与子程序
! ============================================================
!
! 什么是子例程（subroutine）？
!   子例程是一段可重复使用的代码块，类似于其他语言的"过程"或"方法"。
!   它可以接受参数（输入/输出），但不直接返回一个值。
!   通过 call 语句调用。
!
! intent 属性说明：
!   intent(in)    ：参数只读，不能在子例程内修改
!   intent(out)   ：输出参数，进入子例程时视为未定义
!   intent(inout) ：既可以读也可以写
!
program subroutines
  implicit none

  real(8) :: x, y
  real(8) :: arr(5)
  real(8) :: mean_val, std_val

  ! ===== 示例1：交换两个数 =====
  x = 3.0_8
  y = 7.0_8
  print *, "交换前：x =", x, "  y =", y
  call swap(x, y)
  print *, "交换后：x =", x, "  y =", y

  ! ===== 示例2：统计数组的均值和标准差 =====
  arr = [2.0_8, 4.0_8, 4.0_8, 4.0_8, 6.0_8]
  call statistics(arr, 5, mean_val, std_val)
  print *, "数组：", arr
  print *, "均值 =", mean_val
  print *, "标准差 =", std_val

  ! ===== 示例3：打印分隔线（无参数子例程）=====
  call print_separator()
  print *, "上下有分隔线"
  call print_separator()

contains

  !--------------------------------------------------------------
  ! 子例程：交换两个双精度实数
  subroutine swap(a, b)
    real(8), intent(inout) :: a, b   ! 两个参数都需要读写
    real(8) :: tmp
    tmp = a
    a   = b
    b   = tmp
  end subroutine swap

  !--------------------------------------------------------------
  ! 子例程：计算数组的均值和样本标准差
  subroutine statistics(data, n, mean, std)
    integer, intent(in)  :: n              ! 数组长度（只读）
    real(8), intent(in)  :: data(n)        ! 数据数组（只读）
    real(8), intent(out) :: mean           ! 输出：均值
    real(8), intent(out) :: std            ! 输出：标准差

    real(8) :: variance

    mean     = sum(data) / n
    variance = sum((data - mean)**2) / (n - 1)   ! 样本方差（n-1）
    std      = sqrt(variance)
  end subroutine statistics

  !--------------------------------------------------------------
  ! 子例程：打印一条分隔线
  subroutine print_separator()
    print *, repeat("-", 40)   ! repeat("字符", 次数) 重复字符串
  end subroutine print_separator

end program subroutines
