! ============================================================
! 文件名：arrays.f90
! 功  能：演示一维和二维数组的声明、赋值和常用操作
! 对应教材：工程分析程序设计 第4章
!
! 编译命令：gfortran arrays.f90 -o arrays
! 运行命令：./arrays
! ============================================================

program arrays
  implicit none

  integer :: i, j

  ! ── 一维数组 ──────────────────────────────────────────────
  real :: a(5)                        ! 声明有 5 个元素的实数数组
  integer :: scores(6) = [85, 92, 78, 96, 88, 74]  ! 声明并初始化

  ! ── 二维数组（矩阵）──────────────────────────────────────
  real :: matrix(3, 3)               ! 3×3 矩阵
  real :: identity(3, 3) = reshape( &! reshape 把一维列表变成矩阵
    [1.0, 0.0, 0.0,  &               ! 注意：Fortran 按列存储！
     0.0, 1.0, 0.0,  &               ! 这里 reshape 默认按列填充
     0.0, 0.0, 1.0], &
    shape=[3, 3],    &
    order=[2, 1])                    ! order=[2,1] 让它按行填充，符合我们的习惯

  ! ── 一维数组操作 ──────────────────────────────────────────
  print *, "=== 一维数组 ==="

  ! 给 a 赋值（索引从 1 开始，不是 0！）
  a(1) = 1.1
  a(2) = 2.2
  a(3) = 3.3
  a(4) = 4.4
  a(5) = 5.5

  print *, "数组 a 的所有元素："
  print *, a

  print *, "用循环逐个输出数组 a："
  do i = 1, size(a)                  ! size(a) 返回数组的元素个数
    print *, "  a(", i, ") =", a(i)
  end do

  ! ── 内置函数 ──────────────────────────────────────────────
  print *, ""
  print *, "成绩数组 scores =", scores
  print *, "最高分 =", maxval(scores)   ! 最大值
  print *, "最低分 =", minval(scores)   ! 最小值
  print *, "总  分 =", sum(scores)      ! 求和
  print *, "平均分 =", real(sum(scores)) / size(scores)

  ! ── 整体赋值与运算 ────────────────────────────────────────
  print *, ""
  print *, "=== 数组整体运算 ==="
  a = 0.0                              ! 将所有元素置为 0
  print *, "全置 0 后 a =", a

  a = a + 1.0                          ! 每个元素加 1
  print *, "每个元素加 1 后 a =", a

  ! ── 二维数组（矩阵）──────────────────────────────────────
  print *, ""
  print *, "=== 二维数组（矩阵）==="

  ! 给矩阵赋值（先行后列写法）
  do i = 1, 3
    do j = 1, 3
      matrix(i, j) = real(i * 3 + j - 3)  ! 填入 1~9
    end do
  end do

  print *, "矩阵 matrix（逐行输出）："
  do i = 1, 3
    print *, matrix(i, 1), matrix(i, 2), matrix(i, 3)
  end do

  print *, ""
  print *, "单位矩阵 identity："
  do i = 1, 3
    print *, identity(i, 1), identity(i, 2), identity(i, 3)
  end do

  ! ── 动态数组（可分配数组）────────────────────────────────
  block
    real, allocatable :: dyn(:)      ! 声明可分配数组，尺寸待定
    integer :: n
    print *, ""
    print *, "=== 动态数组示例 ==="
    print *, "请输入数组大小 n："
    read *, n
    allocate(dyn(n))                 ! 在运行时分配 n 个元素的空间
    dyn = [(real(i) * 0.1, i = 1, n)]  ! 用隐式 do 循环赋值
    print *, "动态数组 dyn =", dyn
    deallocate(dyn)                  ! 使用完毕后释放内存（好习惯！）
  end block

end program arrays
