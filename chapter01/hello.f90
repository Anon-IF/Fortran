! 第一章示例1：第一个Fortran程序
! 对应教材《工程分析程序设计》第一章
! 知识点：程序结构、print语句、implicit none
program hello
  implicit none   ! 强制显式声明所有变量，避免隐式类型错误
  print *, "你好，Fortran！"
  print *, "Hello, Fortran!"
end program hello
