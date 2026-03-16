! ============================================================
! 文件：file_io.f90
! 功能：演示文件的读取和写入操作
! 对应教材：第7章  文件操作
! ============================================================
!
! 文件操作的基本步骤：
!   1. open  ——打开文件（指定文件名、单元号、操作模式）
!   2. read / write ——读取或写入数据
!   3. close ——关闭文件
!
! open 语句常用参数：
!   unit=   ：文件单元号（正整数，10~99 常用，避免与标准 I/O 冲突）
!   file=   ：文件名（字符串）
!   status= ：'old'（文件必须已存在）| 'new'（创建新文件）| 'replace'（覆盖或创建）
!   action= ：'read' | 'write' | 'readwrite'
!   iostat= ：整数变量，接收 I/O 状态（0 表示成功，非0表示出错）
!
program file_io
  implicit none

  integer :: i, n, ios
  real(8) :: x, result_val
  character(len=100) :: line

  ! ===== 写入文件 =====
  print *, "===== 写入 output.txt ====="
  open(unit=10, file="output.txt", status="replace", action="write", iostat=ios)
  if (ios /= 0) then
    print *, "错误：无法创建 output.txt，错误码 =", ios
    stop
  end if

  write(10, *) "# 这是一个由 Fortran 程序生成的数据文件"
  write(10, *) "# 格式：i  x  x^2"
  do i = 1, 5
    x = real(i, kind=8)
    write(10, "(i4, 2f12.4)") i, x, x**2   ! 格式化写入
  end do
  close(10)
  print *, "已写入 output.txt"

  ! ===== 读取文件 =====
  print *, "===== 读取 output.txt ====="
  open(unit=20, file="output.txt", status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "错误：无法打开 output.txt，错误码 =", ios
    stop
  end if

  ! 跳过注释行（以 # 开头）
  do
    read(20, "(a)", iostat=ios) line    ! 读取整行到字符串
    if (ios /= 0) exit                  ! 读到文件末尾退出
    if (line(1:1) == "#") then
      print *, "注释行：", trim(line)
    else
      print *, "数据行：", trim(line)
    end if
  end do
  close(20)

  ! ===== 读取数值数据 =====
  print *, "===== 再次读取并解析数值 ====="
  open(unit=30, file="output.txt", status="old", action="read")
  read(30, *)   ! 跳过第1行注释
  read(30, *)   ! 跳过第2行注释

  do
    read(30, *, iostat=ios) n, x, result_val
    if (ios /= 0) exit   ! 文件结束
    print "(a, i2, a, f6.1, a, f8.2)", "  行", n, ": x=", x, "  x^2=", result_val
  end do
  close(30)

end program file_io
