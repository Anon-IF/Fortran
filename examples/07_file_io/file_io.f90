! ============================================================
! 文件名：file_io.f90
! 功  能：演示文件读写操作
! 对应教材：工程分析程序设计 第7章
!
! 编译命令：gfortran file_io.f90 -o file_io
! 运行命令：./file_io
! 运行后会在当前目录生成 data.txt 和 output.txt 两个文件
! ============================================================

program file_io
  implicit none

  integer :: i, ios            ! ios 用于检查文件操作是否成功
  real    :: x, y, result
  character(len=100) :: line

  ! ============================================================
  ! 第一步：向文件写入数据
  ! ============================================================
  print *, "=== 写入数据到 data.txt ==="

  ! open 语句用于打开文件
  !   unit=10    ：文件单元号（类似文件句柄），可选 10~99 中的整数
  !   file=...   ：文件名
  !   status=... ："replace" 如果文件存在则覆盖，"new" 文件不存在时创建
  !   action=... ："write" 只写，"read" 只读，"readwrite" 读写
  open(unit=10, file="data.txt", status="replace", action="write")

  ! 写入表头（注释行）
  write(10, *) "# x        y=x^2"

  ! 写入数据
  do i = 1, 10
    x = real(i)
    y = x * x
    write(10, "(f8.2, f12.4)") x, y   ! 格式化输出：f8.2 表示8位宽浮点数保留2位小数
  end do

  close(10)   ! 关闭文件（重要！忘记关闭可能导致数据丢失）
  print *, "data.txt 写入完成！"

  ! ============================================================
  ! 第二步：从文件读取数据并处理
  ! ============================================================
  print *, ""
  print *, "=== 从 data.txt 读取数据 ==="

  open(unit=11, file="data.txt", status="old", action="read")

  ! 先读取并忽略表头行
  read(11, "(a)") line   ! 读取整行到字符串变量 line
  print *, "跳过表头：", trim(line)  ! trim() 去除字符串末尾空格

  ! 循环读取所有数据行
  do
    read(11, *, iostat=ios) x, y   ! iostat=ios：若读到文件末尾，ios 将不为 0
    if (ios /= 0) exit              ! 读取出错或到文件末尾时退出循环
    print *, "x =", x, "  y =", y
  end do

  close(11)

  ! ============================================================
  ! 第三步：将处理结果写入新文件
  ! ============================================================
  print *, ""
  print *, "=== 将结果写入 output.txt ==="

  open(unit=12, file="data.txt",   status="old",     action="read")
  open(unit=13, file="output.txt", status="replace",  action="write")

  read(12, "(a)") line   ! 跳过表头
  write(13, *) "# x        y=x^2       z=sqrt(y)"

  do
    read(12, *, iostat=ios) x, y
    if (ios /= 0) exit
    result = sqrt(y)    ! 计算平方根（应等于 x）
    write(13, "(3f12.4)") x, y, result
  end do

  close(12)
  close(13)
  print *, "output.txt 写入完成！"
  print *, ""
  print *, "提示：用文本编辑器打开 data.txt 和 output.txt 查看结果。"

end program file_io
