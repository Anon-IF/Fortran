! ============================================================
! 文件：gaussian_elim.f90
! 功能：用高斯消去法（带列主元）求解线性方程组 Ax = b
! 对应教材：数值方法 / 线性方程组求解
! ============================================================
!
! 【高斯消去法原理】
!   线性方程组 Ax = b 可以通过"消元"将 A 变成上三角矩阵，
!   然后"回代"求解各个未知数。
!
!   带列主元（partial pivoting）的改进：
!   每次消元前，从当前列找绝对值最大的元素作为主元，
!   可以提高数值稳定性，避免除以很小的数。
!
! 【示例方程组】
!   2x + y - z = 8
!   -3x - y + 2z = -11
!   -2x + y + 2z = -3
!   解：x=2, y=3, z=-1
!
program gaussian_elim
  implicit none

  integer, parameter :: N = 3   ! 方程个数（也是未知数个数）
  real(8) :: A(N, N), b(N), x(N)
  integer :: i, j

  ! ===== 建立方程组 Ax = b =====
  ! 方程1：  2x +  y - z  = 8
  ! 方程2： -3x -  y + 2z = -11
  ! 方程3： -2x +  y + 2z = -3
  A(1, :) = [ 2.0_8,  1.0_8, -1.0_8]
  A(2, :) = [-3.0_8, -1.0_8,  2.0_8]
  A(3, :) = [-2.0_8,  1.0_8,  2.0_8]

  b = [8.0_8, -11.0_8, -3.0_8]

  ! ===== 打印原始方程组 =====
  print *, "===== 原始增广矩阵 [A|b] ====="
  do i = 1, N
    write(*, "(3f8.2, a, f8.2)") (A(i,j), j=1,N), " |", b(i)
  end do
  print *

  ! ===== 调用高斯消去法 =====
  call gauss_solve(A, b, x, N)

  ! ===== 打印结果 =====
  print *, "===== 方程组的解 ====="
  do i = 1, N
    write(*, "(a, i1, a, f12.6)") "x(", i, ") = ", x(i)
  end do
  print *, "期望解：x(1)=2, x(2)=3, x(3)=-1"

contains

  !--------------------------------------------------------------
  ! 子例程：带列主元的高斯消去法
  subroutine gauss_solve(A, b, x, n)
    integer, intent(in) :: n
    real(8), intent(inout) :: A(n, n)   ! 输入矩阵（消元过程会修改它）
    real(8), intent(inout) :: b(n)       ! 右端向量（同步修改）
    real(8), intent(out)   :: x(n)       ! 输出：解向量

    integer :: i, j, k, pivot_row
    real(8) :: max_val, factor, temp
    real(8) :: row_temp(n)

    ! ----- 前向消元（带列主元）-----
    do k = 1, n - 1
      ! 找第 k 列绝对值最大的元素作为主元
      max_val   = abs(A(k, k))
      pivot_row = k
      do i = k + 1, n
        if (abs(A(i, k)) > max_val) then
          max_val   = abs(A(i, k))
          pivot_row = i
        end if
      end do

      ! 若主元行不是当前行，则交换（行交换）
      if (pivot_row /= k) then
        row_temp     = A(k, :)
        A(k, :)      = A(pivot_row, :)
        A(pivot_row, :) = row_temp
        temp         = b(k)
        b(k)         = b(pivot_row)
        b(pivot_row) = temp
        write(*, "(a, i1, a, i1)") "  行交换：行", k, " <-> 行", pivot_row
      end if

      ! 消元：将第 k 列下方元素化为 0
      do i = k + 1, n
        if (abs(A(k, k)) < 1.0e-14_8) then
          print *, "错误：矩阵奇异（主元接近零）！"
          x = 0.0_8
          return
        end if
        factor = A(i, k) / A(k, k)
        A(i, :) = A(i, :) - factor * A(k, :)
        b(i)    = b(i)    - factor * b(k)
      end do
    end do

    ! ----- 回代（从最后一个方程逆向求解）-----
    do i = n, 1, -1
      x(i) = b(i)
      do j = i + 1, n
        x(i) = x(i) - A(i, j) * x(j)
      end do
      x(i) = x(i) / A(i, i)
    end do

  end subroutine gauss_solve

end program gaussian_elim
