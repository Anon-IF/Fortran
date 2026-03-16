! 第五章示例1：子例程（subroutine）
! 对应教材《工程分析程序设计》第五章
! 知识点：subroutine定义与调用、intent属性（in/out/inout）、参数传递
program subroutines
  implicit none
  real :: a, b, temp_a, temp_b
  real :: length, width, area_rect, peri_rect
  integer :: arr(5)

  ! ---- 示例1：交换两个数 ----
  a = 3.5
  b = 7.2
  print *, "交换前：a =", a, "  b =", b
  call swap(a, b)
  print *, "交换后：a =", a, "  b =", b

  ! ---- 示例2：计算矩形面积和周长 ----
  print *, ""
  print *, "请输入矩形的长和宽："
  read *, length, width
  call rect_props(length, width, area_rect, peri_rect)
  print *, "面积 =", area_rect
  print *, "周长 =", peri_rect

  ! ---- 示例3：对数组排序（传递数组） ----
  arr = [5, 3, 8, 1, 9]
  print *, ""
  print *, "排序前：", arr
  call sort_asc(arr, 5)
  print *, "排序后：", arr

contains

  ! 子例程：交换两个实数
  ! intent(inout)：既读取输入值，又向外输出修改后的值
  subroutine swap(x, y)
    real, intent(inout) :: x, y
    real :: tmp
    tmp = x
    x = y
    y = tmp
  end subroutine swap

  ! 子例程：计算矩形的面积和周长
  ! intent(in)：只读输入参数
  ! intent(out)：只写输出参数（调用前的值无意义）
  subroutine rect_props(len, wid, area, perimeter)
    real, intent(in)  :: len, wid      ! 输入：长和宽
    real, intent(out) :: area          ! 输出：面积
    real, intent(out) :: perimeter     ! 输出：周长
    area      = len * wid
    perimeter = 2.0 * (len + wid)
  end subroutine rect_props

  ! 子例程：整数数组升序排序（选择排序）
  subroutine sort_asc(arr, n)
    integer, intent(in)    :: n
    integer, intent(inout) :: arr(n)
    integer :: i, j, min_idx, tmp
    do i = 1, n - 1
      min_idx = i
      do j = i + 1, n
        if (arr(j) < arr(min_idx)) min_idx = j
      end do
      ! 将最小值放到当前位置
      tmp = arr(i)
      arr(i) = arr(min_idx)
      arr(min_idx) = tmp
    end do
  end subroutine sort_asc

end program subroutines
