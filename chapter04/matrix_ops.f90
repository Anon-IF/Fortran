! 第四章示例2：二维数组（矩阵）操作
! 对应教材《工程分析程序设计》第四章
! 知识点：二维数组声明、赋值、矩阵运算（加法、转置、乘法）
program matrix_ops
  implicit none
  integer, parameter :: M = 3, N = 3
  real :: A(M, N), B(M, N), C(M, N), D(M, N)
  integer :: i, j

  ! ---- 赋值：矩阵 A ----
  ! Fortran 中二维数组按"列优先"存储
  ! A(行, 列)
  A(1,1)=1.0; A(1,2)=2.0; A(1,3)=3.0
  A(2,1)=4.0; A(2,2)=5.0; A(2,3)=6.0
  A(3,1)=7.0; A(3,2)=8.0; A(3,3)=9.0

  ! ---- 赋值：矩阵 B（单位矩阵） ----
  B = 0.0
  do i = 1, M
    B(i, i) = 1.0
  end do

  ! ---- 打印矩阵 ----
  call print_matrix(A, M, N, "矩阵 A")
  call print_matrix(B, M, N, "矩阵 B（单位矩阵）")

  ! ---- 矩阵加法 ----
  C = A + B
  call print_matrix(C, M, N, "A + B")

  ! ---- 矩阵转置 ----
  D = transpose(A)
  call print_matrix(D, N, M, "A 的转置")

  ! ---- 矩阵乘法（使用内置函数 matmul） ----
  C = matmul(A, B)   ! A * B（与单位矩阵相乘，结果等于A）
  call print_matrix(C, M, N, "A * B（A乘单位矩阵）")

  ! ---- 逐元素操作（不是矩阵乘法） ----
  C = A * A          ! 每个元素平方（不是矩阵乘法！）
  call print_matrix(C, M, N, "A 逐元素平方（A*A）")

  ! ---- 矩阵的一些统计 ----
  print *, ""
  print *, "=== 矩阵 A 的统计 ==="
  print *, "所有元素之和：", sum(A)
  print *, "所有元素最大值：", maxval(A)
  print *, "所有元素最小值：", minval(A)
  print *, "矩阵大小：", shape(A)

contains

  subroutine print_matrix(mat, rows, cols, label)
    integer, intent(in) :: rows, cols
    real, intent(in) :: mat(rows, cols)
    character(len=*), intent(in) :: label
    integer :: r
    print *, ""
    print *, trim(label), "："
    do r = 1, rows
      print "(3f8.2)", mat(r, 1:cols)
    end do
  end subroutine print_matrix

end program matrix_ops
