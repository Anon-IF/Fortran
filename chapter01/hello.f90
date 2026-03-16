! ============================================================
! 文件：hello.f90
! 功能：第一个 Fortran 程序 —— 在屏幕上显示一行文字
! 对应教材：第1章  Fortran 程序设计基础
! ============================================================
!
! 【给零基础读者的说明】
!   • 感叹号 (!) 开头的行是"注释"，编译器会忽略这些行，
!     它们只是写给人类读者看的说明。
!   • 每个 Fortran 程序都由 program ... end program 包裹。
!   • implicit none 告诉编译器：所有变量必须先声明才能使用，
!     这是一个好习惯，可以避免很多低级错误。
!   • print *, "..." 把引号内的文字打印到屏幕上。
!
! 【如何编译并运行】
!   1. 打开终端（命令提示符）
!   2. 进入本文件所在目录：cd chapter01
!   3. 编译：gfortran hello.f90 -o hello
!   4. 运行：./hello        （Linux/macOS）
!          hello.exe       （Windows）
!
program hello
  implicit none          ! 强制显式声明变量，强烈建议始终加上

  print *, "你好，Fortran！"
  print *, "Hello, Fortran!"
  print *, "欢迎学习 Fortran 程序设计！"

end program hello
