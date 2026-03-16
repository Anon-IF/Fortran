! 工程示例2：高斯消元法求解线性方程组
! 对应教材《工程分析程序设计》工程应用部分
!
! 求解线性方程组 Ax = b
! 使用带部分主元选取的高斯消元法（提高数值稳定性）
!
! 示例方程组（3×3）：
!   2x1 + 1x2 - 1x3 =  8
!  -3x1 - 1x2 + 2x3 = -11
!  -2x1 + 1x2 + 2x3 = -3
! 精确解：x1=2, x2=3, x3=-1
!
! 编译运行：
!   gfortran gaussian_elim.f90 -o gaussian_elim
!   ./gaussian_elim
program gaussian_elim
  implicit none
  integer, parameter :: N = 3
  real(8) :: A(N, N), b(N), x(N)
  real(8) :: aug(N, N+1)    ! 增广矩阵 [A|b]
  integer :: i, j, k, pivot_row
  real(8) :: pivot, factor, max_val, tmp

  ! ---- 初始化方程组系数矩阵和右端向量 ----
  A(1,:) = [ 2.0_8,  1.0_8, -1.0_8]
  A(2,:) = [-3.0_8, -1.0_8,  2.0_8]
  A(3,:) = [-2.0_8,  1.0_8,  2.0_8]
  b = [8.0_8, -11.0_8, -3.0_8]

  ! ---- 打印原始方程组 ----
  print *, "=== 高斯消元法求解线性方程组 Ax = b ==="
  print *, ""
  print *, "系数矩阵 A："
  do i = 1, N
    print "(3f10.4)", A(i, :)
  end do
  print *, "右端向量 b:", b

  ! ---- 构建增广矩阵 ----
  aug(:, 1:N) = A
  aug(:, N+1) = b

  ! ---- 前向消元（带列主元选取） ----
  do k = 1, N
    ! 1. 在第k列中找绝对值最大的元素（主元选取）
    max_val  = abs(aug(k, k))
    pivot_row = k
    do i = k+1, N
      if (abs(aug(i, k)) > max_val) then
        max_val   = abs(aug(i, k))
        pivot_row = i
      end if
    end do

    ! 2. 若主元几乎为零，方程组奇异
    if (max_val < 1.0e-12_8) then
      print *, "错误：系数矩阵奇异，方程组无唯一解！"
      stop
    end if

    ! 3. 交换当前行与主元所在行
    if (pivot_row /= k) then
      do j = 1, N+1
        tmp = aug(k, j)
        aug(k, j) = aug(pivot_row, j)
        aug(pivot_row, j) = tmp
      end do
    end if

    ! 4. 消元
    do i = k+1, N
      factor = aug(i, k) / aug(k, k)
      aug(i, k:N+1) = aug(i, k:N+1) - factor * aug(k, k:N+1)
    end do
  end do

  ! ---- 回代（Back Substitution） ----
  do i = N, 1, -1
    x(i) = aug(i, N+1)
    do j = i+1, N
      x(i) = x(i) - aug(i, j) * x(j)
    end do
    x(i) = x(i) / aug(i, i)
  end do

  ! ---- 输出结果 ----
  print *, ""
  print *, "=== 求解结果 ==="
  do i = 1, N
    write(*, "(a, i1, a, f12.6)") "x(", i, ") = ", x(i)
  end do

  ! ---- 验证：计算残差 Ax - b ----
  print *, ""
  print *, "=== 验证（残差 Ax - b 应接近零）==="
  do i = 1, N
    tmp = dot_product(A(i,:), x) - b(i)
    write(*, "(a, i1, a, e12.4)") "残差(", i, ") = ", tmp
  end do

end program gaussian_elim
