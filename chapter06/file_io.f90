! 第六章示例：文件读写与格式化输入输出
! 对应教材《工程分析程序设计》第六章
! 知识点：open/close/read/write、格式化说明符（format）、文件状态
program file_io
  implicit none
  integer :: i, unit_num, ios
  real :: x, y, result
  real :: data_in(5)
  character(len=100) :: line

  ! ============================================================
  ! 第一部分：格式化输出（写屏）
  ! ============================================================
  print *, "=== 格式化输出示例 ==="

  ! 整数格式：i[宽度]
  write(*, "(i5)")   42         ! 右对齐，宽度5
  write(*, "(i0)")   42         ! 最小宽度

  ! 实数格式：f[宽度].[小数位数]
  write(*, "(f10.4)") 3.14159   ! 宽度10，小数4位
  write(*, "(e12.5)") 0.00314   ! 科学计数法

  ! 混合格式
  write(*, "(a, i4, a, f8.3)") "n =", 10, "  x =", 3.14

  ! 重复格式
  write(*, "(5f8.2)") 1.1, 2.2, 3.3, 4.4, 5.5

  ! ============================================================
  ! 第二部分：写入文件
  ! ============================================================
  print *, ""
  print *, "=== 写入文件 output.txt ==="

  unit_num = 10
  open(unit=unit_num,                &
       file="output.txt",            &
       status="replace",             &  ! 若存在则覆盖
       action="write",               &
       iostat=ios)

  if (ios /= 0) then
    print *, "错误：无法创建文件 output.txt"
    stop
  end if

  ! 写入文件头
  write(unit_num, "(a)") "# 计算结果数据文件"
  write(unit_num, "(a)") "# 格式：i, x, x^2"

  do i = 1, 10
    x = real(i) * 0.5
    write(unit_num, "(i4, 2f10.4)") i, x, x*x
  end do

  close(unit_num)
  print *, "已成功写入 output.txt"

  ! ============================================================
  ! 第三部分：从文件读取
  ! ============================================================
  print *, ""
  print *, "=== 从文件读取 output.txt ==="

  unit_num = 20
  open(unit=unit_num,          &
       file="output.txt",      &
       status="old",           &  ! 文件必须已存在
       action="read",          &
       iostat=ios)

  if (ios /= 0) then
    print *, "错误：无法打开文件 output.txt"
    stop
  end if

  ! 跳过注释行（以#开头）
  read(unit_num, "(a)") line   ! 读第1行（注释）
  read(unit_num, "(a)") line   ! 读第2行（注释）
  print *, "跳过文件头，开始读取数据："

  ! 循环读取直到文件末尾
  do
    read(unit_num, *, iostat=ios) i, x, result
    if (ios /= 0) exit           ! 读到文件末尾或出错时退出
    write(*, "(a, i3, a, f6.2, a, f8.4)") &
          "i =", i, "  x =", x, "  x^2 =", result
  end do

  close(unit_num)

end program file_io
