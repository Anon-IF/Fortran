! ============================================================
! 文件：dynamic_array.f90
! 功能：演示可分配数组（运行时动态决定大小）
! 对应教材：第5章  数组
! ============================================================
!
! 为什么需要动态数组？
!   在编写程序时，我们有时不知道需要处理多少数据。
!   静态数组要求在声明时确定大小；可分配数组让我们在
!   运行时根据实际需要分配内存，更加灵活。
!
program dynamic_array
  implicit none

  integer :: n, i
  real(8), allocatable :: x(:)      ! 声明可分配一维数组（: 是占位符）
  real(8), allocatable :: mat(:,:)  ! 声明可分配二维数组
  real(8) :: avg

  ! ===== 一维动态数组 =====
  print *, "请输入数组大小 n："
  read *, n

  allocate(x(n))        ! 在运行时分配 n 个元素

  print *, "请依次输入", n, "个实数："
  do i = 1, n
    read *, x(i)
  end do

  ! 计算统计量
  avg = sum(x) / n
  print *, "平均值 =", avg
  print *, "最大值 =", maxval(x)
  print *, "最小值 =", minval(x)

  deallocate(x)    ! 释放内存（好习惯，防止内存泄漏）

  ! ===== 检查数组是否已分配 =====
  if (.not. allocated(x)) then
    print *, "x 已被释放"
  end if

  ! ===== 二维动态数组（动态矩阵）=====
  print *, "请输入矩阵的行数和列数："
  read *, n, i             ! 复用 n（行）和 i（列）

  allocate(mat(n, i))
  mat = 0.0_8              ! 整体初始化为 0

  print *, "已创建", n, "行", i, "列的零矩阵"
  print *, "mat(1,1) =", mat(1, 1)

  deallocate(mat)

end program dynamic_array
