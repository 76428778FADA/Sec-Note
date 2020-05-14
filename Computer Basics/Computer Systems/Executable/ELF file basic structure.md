### 简介

ELF （Executable and Linkable Format）文件，也就是在 Linux 中的目标文件格式，主要有以下三种类型

**可重定位文件**（Relocatable File），包含由编译器生成的代码以及数据。链接器会将它与其它目标文件链接起来从而创建可执行文件或者共享目标文件。在 Linux 系统中，这种文件的后缀一般为 .o 。

**可执行文件**（Executable File），就是我们通常在 Linux 中执行的程序。

**共享目标文件**（Shared Object File），包含代码和数据，这种文件是我们所称的库文件，一般以 .so 结尾。一般情况下，它有以下两种使用情景：

链接器（Link eDitor, ld）可能会处理它和其它可重定位文件以及共享目标文件，生成另外一个目标文件。
动态链接器（Dynamic Linker）将它与可执行文件以及其它共享目标组合在一起生成进程镜像。

目标文件由汇编器和链接器创建(这里涉及到编译器驱动程序），是文本程序的二进制形式，可以直接在处理器上运行。那些需要虚拟机才能够执行的程序 (Java) 不属于这一范围。

### 链接

链接（linking）是将各种代码和数据片段收集并组合成为一个单一文件的过程，这个文件可被加载（复制）到内存并执行。

链接可以执行于编译时（compile time），也就是在源代码被编译成机器码时；
也可以执行于加载时（load time），也就是在程序被加载器（loader）加载到内存并执行时；
甚至执行于运行时（run time），也就是由应用程序来执行。

在早期的计算机系统中，链接是手动执行的，而在现代系统中，链接的工作通常是由链接器来默默地处理，这一角色使得分离编译（separate compilation）成为可能。

### 编译器驱动程序

源程序文件都需要使用编译系统翻译成机器代码后，才能在处理机上运行。大多数编译系统提供编译器驱动程序（complier driver），它代表用户在需要时调用语言预处理器、编译器、汇编器和链接器。

![静态链接|链接器将可重定位目标文件组合起来，形成一个可执行目标文件prog](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472273009.png)

上图概括了驱动程序在将main.c从ASCII码源文件翻译成可执行目标文件时的行为

驱动程序首先运行C预处理器（cpp），它将C的源程序main.c翻译成一个ASCII码的中间文件main.i：

``` 
cpp [other arguments] main.c /tmp/main.i
```
接下来，驱动程序运行C编译器（ccl),它将main.i翻译成一个ASCII汇编语言文件main.s:

``` 
ccl /tmp/main.i -0g [other arguments] -o /tmp/main.s
```
然后，驱动程序运行汇编器(as)，将main.s翻译成一个可重定位目标文件(relocatable object file)main.o：

``` 
as [other arguments] -o /tmp/main.o /tmp/main.s
```
> *other arguments:其他参数*

最后，运行链接器程序ld，将main.o及一些必要的系统目标文件组合起来，创建一个可执行目标文件（executable object file)prog；

``` 
ld  -o prog [system object files and args]  /tmp/main.o 
```

运行可执行文件

``` shell
linux> ./prog
```
shell调用操作系统中一个叫做加载器（loader)的函数，可将可执行文件prog中的代码和数据复制到内存，然后将控制转移到这个程序的开头

### 文件格式 

目标文件既会参与程序链接又会参与程序执行。出于方便性和效率考虑，根据过程的不同，目标文件格式提供了其内容的两种并行视图，如下

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472272650.png)