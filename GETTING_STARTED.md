# 入门操作指南：手把手带你运行第一个 Fortran 程序

> 本指南专为**从未使用过命令行、从未写过程序**的零基础初学者编写。

---

## 第一关：了解基本概念

在开始之前，先搞清楚三个问题：

### 1. 什么是"源代码"？
你用 Fortran 语言写的文字（比如 `print *, "Hello"`），就叫**源代码**。  
源代码保存在以 `.f90` 结尾的文本文件里，用任何文本编辑器都能打开和修改。

### 2. 什么是"编译"？
计算机看不懂 Fortran 语言，只懂 0 和 1。**编译**就是把你写的源代码翻译成计算机能直接运行的"机器语言"。  
`gfortran` 就是 Fortran 的编译器（翻译官）。

### 3. 什么是"终端/命令行"？
终端是一个黑色（或白色）的窗口，你可以在里面输入命令让计算机做事。  
- Windows 叫**命令提示符**（cmd）或 **PowerShell**
- macOS 叫**终端**（Terminal）
- Linux 叫**终端**（Terminal）

---

## 第二关：安装 gfortran

### Windows 详细步骤

1. **下载**：打开浏览器，访问 https://winlibs.com/
2. 找到最新版本的 **Release versions** → **UCRT runtime** → 选择 `x86_64`（64位）的 `.zip` 文件下载
3. **解压**：右键点击下载的 `.zip` 文件 → "解压到" → 选择 `C:\`  
   解压后应该有 `C:\mingw64` 这个文件夹
4. **配置环境变量**（让命令行能找到 gfortran）：
   - 按 `Win+S`，搜索"环境变量"，打开"编辑系统环境变量"
   - 点击"环境变量"按钮
   - 在"系统变量"列表中，找到 `Path`，双击它
   - 点击"新建"，输入 `C:\mingw64\bin`
   - 一路点"确定"
5. **验证**：按 `Win+R`，输入 `cmd`，打开命令提示符，输入：
   ```
   gfortran --version
   ```
   如果显示版本号，说明安装成功！

### macOS 详细步骤

1. 按 `Command+空格`，搜索"终端"，打开终端
2. 输入以下命令安装 Homebrew（如果已安装跳过）：
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. 安装 gfortran：
   ```bash
   brew install gcc
   ```
4. 验证：
   ```bash
   gfortran --version
   ```

### Linux（Ubuntu）详细步骤

1. 打开终端
2. 输入：
   ```bash
   sudo apt update
   sudo apt install gfortran
   ```
3. 验证：
   ```bash
   gfortran --version
   ```

---

## 第三关：安装 VS Code（代码编辑器）

1. 访问 https://code.visualstudio.com/ 下载适合你系统的版本
2. 安装（一路下一步即可）
3. 打开 VS Code
4. 点击左侧"扩展"图标（四个方块的图标，或按 `Ctrl+Shift+X`）
5. 在搜索框输入 `Modern Fortran`
6. 点击第一个结果右边的"安装"按钮
7. 安装完成后，`.f90` 文件会有语法高亮显示

---

## 第四关：运行第一个程序

### 步骤 1：创建工作文件夹

- **Windows**：在桌面或 D 盘新建文件夹，命名为 `fortran_learn`
- **macOS/Linux**：在终端输入 `mkdir ~/fortran_learn`

### 步骤 2：用 VS Code 打开文件夹

1. 打开 VS Code
2. 点击菜单"文件" → "打开文件夹"
3. 找到并选择你刚建的 `fortran_learn` 文件夹
4. 点击"选择文件夹"

### 步骤 3：新建 Fortran 源文件

1. 在 VS Code 左侧的"资源管理器"面板，点击"新建文件"图标（或按 `Ctrl+N`）
2. 输入文件名：`hello.f90`（`.f90` 扩展名很重要！）
3. 在右侧编辑区输入以下代码：

```fortran
program hello
  implicit none
  print *, "Hello, Fortran!"
  print *, "我的第一个程序运行成功了！"
end program hello
```

4. 按 `Ctrl+S` 保存文件

### 步骤 4：打开终端

**在 VS Code 中打开终端**（最方便）：
- 按 `Ctrl+反引号`（键盘左上角那个键）
- 或点击菜单"终端" → "新建终端"

终端会自动定位到你的工作文件夹，你可以直接在这里输入命令。

### 步骤 5：编译程序

在终端中输入：
```bash
gfortran hello.f90 -o hello
```

命令解释：
- `gfortran`：调用 Fortran 编译器
- `hello.f90`：要编译的源文件
- `-o hello`：指定生成的可执行文件名叫 `hello`（Windows 上会是 `hello.exe`）

如果没有任何错误提示，说明编译成功！

### 步骤 6：运行程序

**Linux/macOS**：
```bash
./hello
```

**Windows**：
```
hello.exe
```
或者：
```
.\hello.exe
```

看到如下输出，说明成功了！🎉
```
 Hello, Fortran!
 我的第一个程序运行成功了！
```

---

## 第五关：运行本项目的示例程序

克隆或下载本项目后，进入对应目录运行：

```bash
# 进入示例目录
cd examples/01_hello_world

# 编译
gfortran hello.f90 -o hello

# 运行
./hello          # Linux/macOS
hello.exe        # Windows
```

依次尝试各章节的示例程序：

```bash
# 第2章：变量
cd ../02_variables
gfortran variables.f90 -o variables && ./variables

# 第3章：条件判断
cd ../03_control_flow
gfortran if_example.f90 -o if_example && ./if_example

# 第3章：循环
gfortran loop_example.f90 -o loop_example && ./loop_example

# 第4章：数组
cd ../04_arrays
gfortran arrays.f90 -o arrays && ./arrays

# 第5章：函数
cd ../05_functions
gfortran functions.f90 -o functions && ./functions

# 第6章：模块（两个文件一起编译）
cd ../06_modules
gfortran math_module.f90 main_program.f90 -o main_program && ./main_program

# 第7章：文件读写
cd ../07_file_io
gfortran file_io.f90 -o file_io && ./file_io

# 第8章：牛顿法
cd ../08_numerical_methods
gfortran newton_method.f90 -o newton && ./newton

# 第8章：数值积分
gfortran numerical_integration.f90 -o num_int && ./num_int
```

---

## 常见问题解答（FAQ）

**Q：输入 `gfortran` 提示"找不到命令"怎么办？**  
A：说明环境变量没配置好。请重新按照"第二关"中的步骤配置，注意要**重新打开**命令行窗口。

**Q：编译报错看不懂怎么办？**  
A：不要慌！Fortran 的错误信息格式通常是：
```
hello.f90:3:10: Error: ...
```
`hello.f90` 是文件名，`3` 是出错的行号，`10` 是列号，后面是错误描述。根据行号找到代码里对应的位置，通常就能找到问题。

**Q：程序运行时卡住了不动怎么办？**  
A：如果程序需要键盘输入（有 `read *` 语句），请输入数据后按回车。  
如果是死循环，按 `Ctrl+C` 强制终止程序。

**Q：Windows 上中文乱码怎么办？**  
A：在命令提示符中输入 `chcp 65001` 切换到 UTF-8 编码，然后重新运行程序。

**Q：程序结果和预期不一样怎么办？**  
A：在代码中加入 `print *` 输出中间结果，一步步检查每个变量的值，这叫"调试"。

---

> 🎯 **记住**：每次遇到问题都是学习的机会。不要害怕犯错，在 Fortran 学习过程中犯的每个错误都会让你更深刻地理解这门语言。
