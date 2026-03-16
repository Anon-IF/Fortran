! ============================================================
! 文件：matrix_ops.f90
! 功能：演示矩阵运算：转置、矩阵乘法、行列式（初步）
! 对应教材：第5章  数组 / 工程应用
! ============================================================

program matrix_ops
  implicit none

  integer :: i
  real(8) :: A(3, 3), B(3, 3), C(3, 3), AT(3, 3)

  ! ===== 初始化矩阵 A =====
  ! A = | 1 2 3 |
  !     | 4 5 6 |
  !     | 7 8 9 |
  A(1, :) = [1.0_8, 2.0_8, 3.0_8]   ! 第1行全部赋值（: 表示该维全部元素）
  A(2, :) = [4.0_8, 5.0_8, 6.0_8]
  A(3, :) = [7.0_8, 8.0_8, 9.0_8]

  ! ===== 初始化矩阵 B（单位矩阵）=====
  B = 0.0_8
  do i = 1, 3
    B(i, i) = 1.0_8
  end do

  ! ===== 打印矩阵工具 =====
  print *, "矩阵 A："
  call print_matrix(A, 3, 3)

  print *, "矩阵 B（单位矩阵）："
  call print_matrix(B, 3, 3)

  ! ===== 矩阵转置 =====
  AT = transpose(A)   ! 内置函数
  print *, "A 的转置（A^T）："
  call print_matrix(AT, 3, 3)

  ! ===== 矩阵乘法 =====
  C = matmul(A, B)    ! 内置矩阵乘法函数
  print *, "A × B（A乘以单位矩阵，结果应等于A）："
  call print_matrix(C, 3, 3)

  ! ===== 按元素运算（不是矩阵乘法！）=====
  print *, "A 中每个元素乘以 2（不是矩阵乘法）："
  call print_matrix(A * 2.0_8, 3, 3)

contains

  !--------------------------------------------------------------
  ! 子例程：格式化打印矩阵
  subroutine print_matrix(M, rows, cols)
    integer, intent(in) :: rows, cols
    real(8), intent(in) :: M(rows, cols)
    integer :: r, c
    do r = 1, rows
      write(*, "(*(f8.2))") (M(r, c), c=1, cols)
    end do
    print *   ! 输出空行
  end subroutine print_matrix

end program matrix_ops
