! 第四章示例1：一维数组的基本操作
! 对应教材《工程分析程序设计》第四章
! 知识点：数组声明、初始化、索引（从1开始）、整体运算
program array_basic
  implicit none
  integer, parameter :: N = 10
  real :: a(N), b(N), c(N)
  real :: total, avg, max_val, min_val
  integer :: i, pos

  ! ---- 方法1：循环赋值 ----
  do i = 1, N
    a(i) = real(i) * 2.0   ! a = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
  end do

  ! ---- 方法2：数组构造器 ----
  b = [1.0, 3.0, 5.0, 7.0, 9.0, 2.0, 4.0, 6.0, 8.0, 10.0]

  ! ---- 输出数组 ----
  print *, "数组 a（偶数序列）："
  print "(10f6.1)", a

  print *, "数组 b（自定义）："
  print "(10f6.1)", b

  ! ---- 内置函数统计 ----
  total   = sum(a)          ! 求和
  avg     = total / real(N) ! 平均值
  max_val = maxval(a)       ! 最大值
  min_val = minval(a)       ! 最小值
  pos     = maxloc(a, 1)    ! 最大值所在下标

  print *, ""
  print *, "=== 数组 a 的统计量 ==="
  print *, "元素个数：", size(a)
  print *, "总和    ：", total
  print *, "平均值  ：", avg
  print *, "最大值  ：", max_val, "（位置", pos, "）"
  print *, "最小值  ：", min_val

  ! ---- 整体运算（逐元素） ----
  c = a + b          ! 对应元素相加
  print *, ""
  print *, "a + b ="
  print "(10f6.1)", c

  c = a * 0.5        ! 每个元素乘以0.5
  print *, "a * 0.5 ="
  print "(10f6.1)", c

  ! ---- 数组切片（部分元素） ----
  print *, ""
  print *, "a 的第3到第7个元素："
  print "(5f6.1)", a(3:7)

  print *, "a 中下标为奇数的元素（步长2）："
  print "(5f6.1)", a(1:N:2)

  ! ---- 排序（冒泡排序演示） ----
  call bubble_sort(b, N)
  print *, ""
  print *, "b 排序后（升序）："
  print "(10f6.1)", b

contains

  ! 冒泡排序子程序（就地排序）
  subroutine bubble_sort(arr, n)
    integer, intent(in) :: n
    real, intent(inout) :: arr(n)
    integer :: i, j
    real :: temp
    do i = 1, n - 1
      do j = 1, n - i
        if (arr(j) > arr(j+1)) then
          temp = arr(j)
          arr(j) = arr(j+1)
          arr(j+1) = temp
        end if
      end do
    end do
  end subroutine bubble_sort

end program array_basic
