! 第四章示例3：可分配数组（动态数组）
! 对应教材《工程分析程序设计》第四章
! 知识点：allocatable、allocate、deallocate、运行时确定数组大小
program dynamic_array
  implicit none
  integer :: n, m, i, j
  real, allocatable :: vec(:)       ! 一维可分配数组
  real, allocatable :: mat(:, :)    ! 二维可分配数组
  integer, allocatable :: index_arr(:)

  ! ---- 运行时决定数组大小 ----
  print *, "请输入向量长度 n："
  read *, n

  allocate(vec(n))       ! 分配内存
  allocate(index_arr(n))

  ! 赋值
  do i = 1, n
    vec(i) = sqrt(real(i))   ! vec = [√1, √2, √3, ..., √n]
    index_arr(i) = i
  end do

  print *, "向量元素（每个元素为其下标的平方根）："
  do i = 1, n
    write(*, "(i3, a, f8.4)") i, " -> ", vec(i)
  end do
  print *, "向量总和 =", sum(vec)

  deallocate(vec)         ! 释放内存（好习惯）
  deallocate(index_arr)

  ! ---- 二维动态数组 ----
  print *, ""
  print *, "请输入矩阵行数 m 和列数 n："
  read *, m, n

  allocate(mat(m, n))

  ! 初始化：mat(i,j) = i * j
  do i = 1, m
    do j = 1, n
      mat(i, j) = real(i * j)
    end do
  end do

  print *, "矩阵（mat(i,j) = i*j）："
  do i = 1, m
    do j = 1, n
      write(*, "(f6.0)", advance="no") mat(i, j)
    end do
    print *
  end do

  ! 检查数组是否已分配
  if (allocated(mat)) then
    print *, ""
    print *, "mat 已分配，大小为：", size(mat), "个元素"
    deallocate(mat)
    print *, "mat 已释放。"
  end if

end program dynamic_array
