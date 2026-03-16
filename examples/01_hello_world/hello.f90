! ============================================================
! 文件名：hello.f90
! 功  能：第一个 Fortran 程序 —— 在屏幕上打印一句话
! 对应教材：工程分析程序设计 第1章
!
! 编译命令：gfortran hello.f90 -o hello
! 运行命令：./hello          （Linux/macOS）
!           hello.exe        （Windows）
! ============================================================

program hello                    ! program 关键字表示程序开始，hello 是程序名
  implicit none                  ! 强制所有变量必须先声明再使用（初学者必写！）

  print *, "Hello, Fortran!"     ! print * 表示向屏幕输出内容，* 表示默认格式
  print *, "欢迎学习 Fortran！"

end program hello                ! 程序结束
