! 第一章示例2：基本输入输出
! 对应教材《工程分析程序设计》第一章
! 知识点：read、print、write语句
program basic_io
  implicit none
  real :: x
  integer :: n
  character(len=20) :: name

  ! 输出提示，然后读取用户输入
  write(*, *) "请输入您的姓名："
  read(*, *) name

  write(*, *) "请输入一个整数："
  read(*, *) n

  write(*, *) "请输入一个实数："
  read(*, *) x

  ! 输出结果
  write(*, *) "姓名：", trim(name)
  write(*, *) "整数：", n
  write(*, *) "实数：", x
  write(*, *) "整数的两倍：", 2 * n
  write(*, *) "实数的平方：", x * x

end program basic_io
