* [Shell 编程入门](#shell-编程入门)
	* [走进 Shell 编程的大门](#走进-shell-编程的大门)
		* [为什么要学Shell？](#为什么要学shell)
		* [什么是 Shell？](#什么是-shell)
		* [Shell 编程的 Hello World](#shell-编程的-hello-world)
	* [Shell 变量](#shell-变量)
		* [Shell 编程中的变量介绍](#shell-编程中的变量介绍)
		* [只读变量](#只读变量)
		* [删除变量](#删除变量)
		* [Shell 字符串入门](#shell-字符串入门)
		* [Shell 字符串常见操作](#shell-字符串常见操作)
		* [查找子字符串](#查找子字符串)
		* [Shell 数组](#shell-数组)
		* [读取数组](#读取数组)
		* [获取数组的长度](#获取数组的长度)
	* [Shell 注释](#shell-注释)
		* [多行注释](#多行注释)
	* [Shell 传递参数](#shell-传递参数)
		* [实例](#实例)
	* [Shell 基本运算符](#shell-基本运算符)
		* [算数运算符](#算数运算符)
		* [关系运算符](#关系运算符)
		* [逻辑运算符](#逻辑运算符)
		* [布尔运算符](#布尔运算符)
		* [字符串运算符](#字符串运算符)
		* [文件相关运算符](#文件相关运算符)
			* [实例](#实例)
	* [Shell echo 命令](#shell-echo-命令)
		* [1.显示普通字符串:](#1显示普通字符串)
		* [2.显示转义字符](#2显示转义字符)
		* [3.显示变量](#3显示变量)
		* [4.显示换行](#4显示换行)
		* [5.显示不换行](#5显示不换行)
		* [6.显示结果定向至文件](#6显示结果定向至文件)
		* [7.原样输出字符串，不进行转义或取变量(用单引号)](#7原样输出字符串不进行转义或取变量用单引号)
		* [8.显示命令执行结果](#8显示命令执行结果)
	* [Shell printf 命令](#shell-printf-命令)
		* [printf的转义序列](#printf的转义序列)
		* [实例](#实例)
	* [Shell test 命令](#shell-test-命令)
		* [数值测试](#数值测试)
		* [字符串测试](#字符串测试)
		* [文件测试](#文件测试)
	* [Shell流程控制](#shell流程控制)
		* [if 条件语句](#if-条件语句)
		* [for 循环语句](#for-循环语句)
		* [while 语句](#while-语句)
	* [Shell 函数](#shell-函数)
		* [不带参数没有返回值的函数](#不带参数没有返回值的函数)
		* [有返回值的函数](#有返回值的函数)
		* [带参数的函数](#带参数的函数)
	* [Shell 输入/输出重定向](#shell-输入输出重定向)
		* [输出重定向](#输出重定向)
		* [输入重定向](#输入重定向)
		* [实例](#实例)
		* [重定向深入讲解](#重定向深入讲解)
		* [Here Document](#here-document)
		* [实例](#实例)
		* [/dev/null 文件](#devnull-文件)
	* [Shell 文件包含](#shell-文件包含)
		* [实例](#实例)

# Shell 编程入门

## 走进 Shell 编程的大门

### 为什么要学Shell？

学一个东西，我们大部分情况都是往实用性方向着想。从工作角度来讲，学习 Shell 是为了提高我们自己工作效率，提高产出，让我们在更少的时间完成更多的事情。

很多人会说 Shell 编程属于运维方面的知识了，应该是运维人员来做，我们做后端开发的没必要学。我觉得这种说法大错特错，相比于专门做Linux运维的人员来说，我们对 Shell 编程掌握程度的要求要比他们低，但是shell编程也是我们必须要掌握的！

目前Linux系统下最流行的运维自动化语言就是Shell和Python了。

两者之间，Shell几乎是IT企业必须使用的运维自动化编程语言，特别是在运root维工作中的服务监控、业务快速部署、服务启动停止、数据备份及处理、日志分析等环节里，shell是不可缺的。Python 更适合处理复杂的业务逻辑，以及开发复杂的运维软件工具，实现通过web访问等。Shell是一个命令解释器，解释执行用户所输入的命令和程序。一输入命令，就立即回应的交互的对话方式。

### 什么是 Shell？

简单来说“Shell编程就是对一堆Linux命令的逻辑化处理”。

W3Cschool 上的一篇文章是这样介绍 Shell的，如下图所示。

首先让我们从下图看看shell在整个操作系统中所处的位置吧，该图的外圆描述了整个操作系统（比如`Debian/Ubuntu/Slackware`等），内圆描述了操作系统的核心（比如`Linux Kernel`），而`shell`和`GUI`意义作为用户和操作系统之间的接口

![](https://www.github.com/Qymua/bookmaker-data/raw/master/Qymua/1566633966528.png)

`GUI`提供了一种图形化的用户接口，使用起来非常简便易学；而`shell`则为用户提供了一种命令行的接口，接收用户的键盘输入，并分析和执行输入字符串中的命令，然后给用户返回执行结果，使用起来可能会复杂一些，但是由于占用的资源少，而且在操作熟练以后可能会提高工作效率，而且具有批处理的功能，因此在某些应用场合非常流行

### Shell 编程的 Hello World

学习任何一门编程语言第一件事就是输出HelloWord了！下面我会从新建文件到shell代码编写来说下Shell 编程如何输出Hello World。


(1)新建一个文件 helloworld.sh :`touch helloworld.sh`，扩展名为 sh（sh代表Shell）（扩展名并不影响脚本执行，见名知意就好，如果你用 php 写 shell 脚本，扩展名就用 php 好了）

(2) 使脚本具有执行权限：`chmod +x helloworld.sh`

(3) 使用 vim 命令修改helloworld.sh文件：`vim helloworld.sh`(vim 文件------>进入文件----->命令模式------>按i进入编辑模式----->编辑文件 ------->按Esc进入底行模式----->输入:wq/q! （输入wq代表写入内容并退出，即保存；输入q!代表强制退出不保存。）)

helloworld.sh 内容如下：

```shell
#!/bin/bash
#第一个shell小程序,echo 是linux中的输出命令。
echo  "helloworld!"
```

shell中 # 符号表示注释。**shell 的第一行比较特殊，一般都会以#!开始来指定使用的 shell 类型。在linux中，除了bash shell以外，还有很多版本的shell， 例如zsh、dash等等...不过bash shell还是我们使用最多的。**


(4) 运行脚本:`./helloworld.sh` 。（注意，一定要写成 `./helloworld.sh` ，而不是 `helloworld.sh` ，运行其它二进制的程序也一样，直接写 `helloworld.sh` ，linux 系统会去 PATH 里寻找有没有叫 helloworld.sh 的，而只有 /bin, /sbin, /usr/bin，/usr/sbin 等在 PATH 里，你的当前目录通常不在 PATH 里，所以写成 `helloworld.sh` 是会找不到命令的，要用`./helloworld.sh` 告诉系统说，就在当前目录找。）

![](https://www.github.com/Qymua/bookmaker-data/raw/master/Qymua/1566650901876.png)



另一种运行脚本的方式是直接运行解释器，其参数就是 shell 脚本的文件名：

```shell
/bin/sh test.sh
/bin/php test.php
```

这种方式运行的脚本，不需要在第一行指定解释器信息，写了也没用。

## Shell 变量

### Shell 编程中的变量介绍


**Shell编程中一般分为三种变量：**

1. **我们自己定义的变量（自定义变量）:** 仅在当前 Shell 实例中有效，其他 Shell 启动的程序不能访问局部变量。
2. **Linux已定义的环境变量**（环境变量， 例如：$PATH, $HOME 等..., 这类变量我们可以直接使用），使用 `env` 命令可以查看所有的环境变量，而set命令既可以查看环境变量也可以查看自定义变量。
3. **Shell变量** ：Shell变量是由 Shell 程序设置的特殊变量。Shell 变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了 Shell 的正常运行

**常用的环境变量:**
> PATH 决定了shell将到哪些目录中寻找命令或程序 
HOME 当前用户主目录 
HISTSIZE　历史记录数 
LOGNAME 当前用户的登录名 
HOSTNAME　指主机的名称 
SHELL 当前用户Shell类型 
LANGUGE 　语言相关的环境变量，多语言可以修改此环境变量 
MAIL　当前用户的邮件存放目录 
PS1　基本提示符，对于root用户是#，对于普通用户是$
(以上都得大写)

**使用 Linux 已定义的环境变量：**

比如我们要看当前用户目录可以使用：`echo $HOME`命令；如果我们要看当前用户Shell类型 可以使用`echo $SHELL`命令。可以看出，使用方法非常简单。

**使用自己定义的变量：**

```shell
#!/bin/bash
#自定义变量hello
#定义变量时，变量名不加美元符号（$，PHP语言中变量需要）
hello="hello world"
echo $hello
echo  "helloworld!"
```
![](https://www.github.com/Qymua/bookmaker-data/raw/master/Qymua/1566652459900.png)

**Shell 编程中的变量名的命名的注意事项：**


- 变量名和等号之间不能有空格
- 命名只能使用英文字母，数字和下划线，首个字符不能以数字开头，但是可以使用下划线（_）开头。
- 中间不能有空格，可以使用下划线（_）。
- 不能使用标点符号。
- 不能使用bash里的关键字（可用help命令查看保留关键字）。

### 只读变量

使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：

```
#!/bin/bash
myUrl="http://www.google.com"
readonly myUrl
myUrl="http://qymua.com"
```

运行脚本，结果如下：

```shell
/bin/sh: NAME: This variable is read only.
```

### 删除变量

使用 unset 命令可以删除变量。语法：

```
unset variable_name
```

变量被删除后不能再次使用。unset 命令不能删除只读变量。

**实例**

```shell
#!/bin/sh
myUrl="http://qymua.com"
unset myUrl
echo $myUrl
```



### Shell 字符串入门

字符串是shell编程中最常用最有用的数据类型（除了数字和字符串，也没啥其它类型好用了），字符串可以用单引号，也可以用双引号。这点和Java中有所不同。

**单引号字符串：**

```shell
#!/bin/bash
name='SnailClimb'
hello='Hello, I  am '$name'!'
echo $hello
```
输出内容：

```
Hello, I am SnailClimb!
```

**单引号字符串的限制：**

- 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
- 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

**双引号字符串：**

```shell
#!/bin/bash
name='SnailClimb'
hello="Hello, I  am "$name"!"
echo $hello
```

输出内容：

```
Hello, I am SnailClimb!
```

双引号的优点：

- 双引号里可以有变量
- 双引号里可以出现转义字符(反斜杠跟上想转义的符号)

### Shell 字符串常见操作

**拼接字符串：**

```shell
#!/bin/bash
name="SnailClimb"
# 使用双引号拼接
greeting="hello, "$name" !"
#变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界
greeting_1="hello, ${name} !"
echo $greeting  $greeting_1
# 使用单引号拼接
greeting_2='hello, '$name' !'
greeting_3='hello, ${name} !'
echo $greeting_2  $greeting_3
```

输出结果：

![](https://www.github.com/Qymua/bookmaker-data/raw/master/Qymua/1566654660953.png)

**获取字符串长度：**

```shell
#!/bin/bash
#获取字符串长度
name="SnailClimb"
# 第一种方式 （#跟上变量名，不会输出变量内容，而是输出长度）
echo ${#name} #输出 10
# 第二种方式
expr length "$name";
```

输出结果:
```
10
10
```

使用 expr 命令时，表达式中的**运算符左右**必须包含空格，如果不包含空格，将会输出表达式本身:

```shell
expr 5+6    // 直接输出 5+6
expr 5 + 6       // 输出 11
```
对于某些运算符，还需要我们使用符号`\`进行转义，否则就会提示语法错误。

```shell
expr 5 * 6       // 输出错误
expr 5 \* 6      // 输出30
```

**截取子字符串:**

简单的字符串截取：


```shell
#从字符串第 1 个字符开始往后截取 10 个字符
str="SnailClimb is a great man"
echo ${str:0:10} #输出:SnailClimb
```

### 查找子字符串

查找字符 **i** 或 **o** 的位置(哪个字母先出现就计算哪个)：

```shell
string="runoob is a great site"
echo `expr index "$string" io`  # 输出 4
```

**注意：** 以上脚本中 **`** 是反引号，而不是单引号 **'**

### Shell 数组

bash支持一维数组（不支持多维数组），并且没有限定数组的大小。我下面给了大家一个关于数组操作的 Shell 代码示例，通过该示例大家可以知道如何**创建数组**、获取**数组长度**、**获取/删除特定位置的数组元素**、**删除整个数组**以及**遍历数组**。


```shell
#!/bin/bash
array=(1 2 3 4 5);
# 获取数组长度
length=${#array[@]}
# 或者
length2=${#array[*]}
#输出数组长度0
echo $length #输出：5
echo $length2 #输出：5
# 输出数组第三个元素
echo ${array[2]} #输出：3
unset array[1]# 删除下标为1的元素也就是删除第二个元素
for i in ${array[@]};do echo $i ;done # 遍历数组，输出： 1 3 4 5 
unset array[@]; # 删除数组中的所有元素
for i in ${array[@]};do echo $i ;done # 遍历数组，数组元素为空，没有任何输出内容
```

在 Shell 中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为：

```
数组名=(值1 值2 ... 值n)
```

例如：

```shell
array_name=(value0 value1 value2 value3)
```

或者

```shell
array_name=(
value0
value1
value2
value3
)
```

还可以单独定义数组的各个分量：

```
array_name[0]=value0
array_name[1]=value1
array_name[n]=valuen
```

可以不使用连续的下标，而且下标的范围没有限制。

### 读取数组

读取数组元素值的一般格式是：

```
${数组名[下标]}
```

例如：

```
valuen=${array_name[n]}
```

使用 **@** 符号可以获取数组中的所有元素，例如：

```shell
echo ${array_name[@]}
```

### 获取数组的长度

获取数组长度的方法与获取字符串长度的方法相同，例如：

```
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]} 
```

## Shell 注释

以 **#** 开头的行就是注释，会被解释器忽略。

通过每一行加一个 **#** 号设置多行注释，像这样：

```
#--------------------------------------------
# 这是一个注释
# author：酋小木
# site：qymua.com
# slogan：学的不仅是技术，更是梦想！
#--------------------------------------------
##### 用户配置区 开始 #####
#
#
# 这里可以添加脚本描述信息
# 
#
##### 用户配置区 结束  #####
```

如果在开发过程中，遇到大段的代码需要临时注释起来，过一会儿又取消注释，怎么办呢？

每一行加个#符号太费力了，可以把这一段要注释的代码用一对花括号括起来，定义成一个函数，没有地方调用这个函数，这块代码就不会执行，达到了和注释一样的效果。

### 多行注释

多行注释还可以使用以下格式：

```
:<<EOF
注释内容...
注释内容...
注释内容...
EOF
```

去掉`:`EOF可以当作文本终止符来看，即将EOF之间的文本`<<`导入

EOF 也可以使用其他符号:

```
:<<'
注释内容...
注释内容...
注释内容...
'

:<<!
注释内容...
注释内容...
注释内容...
!
```

## Shell 传递参数

我们可以在执行 Shell 脚本时，向脚本传递参数，脚本内获取参数的格式为：**$n**。**n** 代表一个数字，1 为执行脚本的第一个参数，2 为执行脚本的第二个参数，以此类推……

### 实例

以下实例我们向脚本传递三个参数，并分别输出，其中 **$0** 为执行的文件名：

```shell
#!/bin/bash
# author:酋小木
# url:qymua.com

echo "Shell 传递参数实例！";
echo "执行的文件名：$0";
echo "第一个参数为：$1";
echo "第二个参数为：$2";
echo "第三个参数为：$3";
```

为脚本设置可执行权限，并执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh 
$ ./test.sh 1 2 3
Shell 传递参数实例！
执行的文件名：./test.sh
第一个参数为：1
第二个参数为：2
第三个参数为：3
```

另外，还有几个特殊字符用来处理参数：

| 参数处理 | 说明                                                         |
| -------- | ------------------------------------------------------------ |
| $#       | 传递到脚本的参数个数                                         |
| $*       | 以一个单字符串显示所有向脚本传递的参数。 如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。 |
| $$       | 脚本运行的当前进程ID号                                       |
| $!       | 后台运行的最后一个进程的ID号                                 |
| $@       | 与$*相同，但是使用时加引号，并在引号中返回每个参数。 如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。 |
| $-       | 显示Shell使用的当前选项，与[set命令](https://qymua.com/linux/linux-comm-set.html)功能相同。 |
| $?       | 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。 |

```shell
#!/bin/bash
# author:酋小木
# url:qymua.com

echo "Shell 传递参数实例！";
echo "第一个参数为：$1";

echo "参数个数为：$#";
echo "传递的参数作为一个字符串显示：$*";
```

执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh 
$ ./test.sh 1 2 3
Shell 传递参数实例！
第一个参数为：1
参数个数为：3
传递的参数作为一个字符串显示：1 2 3
```

$* 与 $@ 区别：

- 相同点：都是引用所有参数。
- 不同点：只有在双引号中体现出来。假设在脚本运行时写了三个参数 1、2、3，，则 " * " 等价于 "1 2 3"（传递了一个参数），而 "@" 等价于 "1" "2" "3"（传递了三个参数）。

```shell
#!/bin/bash
# author:酋小木
# url:qymua.com

echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done

echo "-- \$@ 演示 ---"
for i in "$@"; do
    echo $i
done
```

执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh 
$ ./test.sh 1 2 3
-- $* 演示 ---
1 2 3
-- $@ 演示 ---
1
2
3
```

## Shell 基本运算符

> 说明：图片来自《酋小木》

 Shell 编程支持下面几种运算符

- 算数运算符
- 关系运算符
- 布尔运算符
- 字符串运算符
- 文件测试运算符

### 算数运算符

![算数运算符](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-11-22/4937342.jpg)

原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。

expr 是一款表达式计算工具，使用它能完成表达式的求值操作。使用时最外层一定要用**`** 

引申一个使用技巧：

shell中将命令结果赋值给变量

两种方法，但推荐使用后者，支持嵌套

```
var=`command`
var=$(command)
```

我以加法运算符做一个简单的示例（**注意：不是单引号，是反引号**）：

```shell
#!/bin/bash
a=3;b=3;
val=`expr $a + $b`
#输出：Total value : 6
echo "Total value : $val"
```


### 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

![shell关系运算符](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-11-22/64391380.jpg)

通过一个简单的示例演示关系运算符的使用，下面shell程序的作用是当score=100的时候输出A否则输出B。

```shell
#!/bin/bash
score=90;
maxscore=100;
if [ $score -eq $maxscore ]
then
   echo "A"
else
   echo "B"
fi
```

输出结果：

```
B
```

### 逻辑运算符

![逻辑运算符](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-11-22/60545848.jpg)

示例：

```shell
#!/bin/bash
a=$(( 1 && 0))
# 输出：0；逻辑与运算只有相与的两边都是1，与的结果才是1；否则与的结果是0
echo $a;
```

单独一个`&`跟在指令后代表该后台运行

### 布尔运算符


![布尔运算符](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-11-22/93961425.jpg)

这里就不做演示了，应该挺简单的。

### 字符串运算符

![ 字符串运算符](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-11-22/309094.jpg)

**条件判断都用[]**

简单示例：

```shell
#!/bin/bash
a="abc";
b="efg";
if [ $a = $b ]
then
   echo "a 等于 b"
else
   echo "a 不等于 b"
fi
```
输出：

```
a 不等于 b
```

### 文件相关运算符

![文件相关运算符](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-11-22/60359774.jpg)

其他检查符：

- **-S**: 判断某文件是否 socket。
- **-L**: 检测文件是否存在并且是一个符号链接。

使用方式很简单，比如我们定义好了一个文件路径`file="/usr/learnshell/test.sh"` 如果我们想判断这个文件是否可读，可以这样`if [ -r $file ]` 如果想判断这个文件是否可写，可以这样`-w $file`，是不是很简单。

#### 实例

变量 file 表示文件 /var/www/runoob/test.sh，它的大小为 100 字节，具有 rwx权限。下面的代码，将检测该文件的各种属性：

```
#!/bin/bash
# author:酋小木
# url:qymua.com

file="/var/www/runoob/test.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi
```

## Shell echo 命令

shell脚本中echo显示内容带颜色显示,echo显示带颜色，需要使用参数-e 
格式如下： 

```
echo -e "\033[字背景颜色；文字颜色m字符串\033[0m" 
```

例如： 

```
echo -e "\033[41;36m something here \033[0m" 
```

其中41的位置代表底色， 36的位置是代表字的颜色 
注： 
　　

1、字背景颜色和文字颜色之间是英文的"" 
　　

2、文字颜色后面有个m 
　　

3、字符串前后可以没有空格，如果有的话，输出也是同样有空格 
　　

下面是相应的字和背景颜色，可以自己来尝试找出不同颜色搭配 
例 

```shell
echo -e “\033[31m 红色字 \033[0m” 
echo -e “\033[34m 黄色字 \033[0m” 
echo -e “\033[41;33m 红底黄字 \033[0m” 
echo -e “\033[41;37m 红底白字 \033[0m” 
#字颜色：30—–37 
#字背景颜色范围：40—–47 
```

最后面控制选项说明 

```shell
　　\33[0m 关闭所有属性 
　　\33[1m 设置高亮度 
　　\33[4m 下划线 
　　\33[5m 闪烁 
　　\33[7m 反显 
　　\33[8m 消隐 
　　\33[30m — \33[37m 设置前景色 
　　\33[40m — \33[47m 设置背景色 
　　\33[nA 光标上移n行 
　　\33[nB 光标下移n行 
　　\33[nC 光标右移n行 
　　\33[nD 光标左移n行 
　　\33[y;xH设置光标位置 
　　\33[2J 清屏 
　　\33[K 清除从光标到行尾的内容 
　　\33[s 保存光标位置 
　　\33[u 恢复光标位置 
　　\33[?25l 隐藏光标 
　　\33[?25h 显示光标
```

Shell 的 echo 指令与 PHP 的 echo 指令类似，都是用于字符串的输出。命令格式：

```
echo string
```

您可以使用echo实现更复杂的输出格式控制。

### 1.显示普通字符串:

```
echo "It is a test"
```

这里的双引号完全可以省略，以下命令与上面实例效果一致：

```
echo It is a test
```

### 2.显示转义字符

```
echo "\"It is a test\""
```

结果将是:

```
"It is a test"
```

同样，双引号也可以省略

### 3.显示变量

read 命令从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量

```
#!/bin/sh
read name 
echo "$name It is a test"
```

以上代码保存为 test.sh，name 接收标准输入的变量，结果将是:

```
[root@www ~]# sh test.sh
OK                     #标准输入
OK It is a test        #输出
```

### 4.显示换行

```
echo -e "OK! \n" # -e 开启转义
echo "It is a test"
```

输出结果：

```
OK!

It is a test
```

### 5.显示不换行

```
#!/bin/sh
echo -e "OK! \c" # -e 开启转义 \c 不换行
echo "It is a test"
```

输出结果：

```
OK! It is a test
```

### 6.显示结果定向至文件

```
echo "It is a test" > myfile
```

### 7.原样输出字符串，不进行转义或取变量(用单引号)

```
echo '$name\"'
```

输出结果：

```
$name\"
```

### 8.显示命令执行结果

```
echo `date`
```

**注意：** 这里使用的是反引号 **`**, 而不是单引号 **'**。

结果将显示当前日期

```
Thu Jul 24 10:08:46 CST 2014
```

## Shell printf 命令

printf 命令模仿 C 程序库（library）里的 printf() 程序。

printf 由 POSIX 标准所定义，因此使用 printf 的脚本比使用 echo 移植性好。

printf 使用引用文本或空格分隔的参数，外面可以在 printf 中使用格式化字符串，还可以制定字符串的宽度、左右对齐方式等。默认 printf 不会像 echo 自动添加换行符，我们可以手动添加 \n。

printf 命令的语法：

```
printf  format-string  [arguments...]
```

**参数说明：**

- **format-string:** 为格式控制字符串
- **arguments:** 为参数列表

实例如下：

```
$ echo "Hello, Shell"
Hello, Shell
$ printf "Hello, Shell\n"
Hello, Shell
$
```

接下来,我来用一个脚本来体现printf的强大功能：

```
#!/bin/bash
# author:酋小木
# url:qymua.com
 
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 
```

执行脚本，输出结果如下所示：

```
姓名     性别   体重kg
郭靖     男      66.12
杨过     男      48.65
郭芙     女      47.99
```

%s %c %d %f都是**格式替代符**

%-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐），任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。

%-4.2f 指格式化为小数，其中.2指保留2位小数。



更多实例：

```
#!/bin/bash
# author:酋小木
# url:qymua.com
 
# format-string为双引号
printf "%d %s\n" 1 "abc"

# 单引号与双引号效果一样 
printf '%d %s\n' 1 "abc" 

# 没有引号也可以输出
printf %s abcdef

# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf %s abc def

printf "%s\n" abc def

printf "%s %s %s\n" a b c d e f g h i j

# 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
printf "%s and %d \n" 
```

执行脚本，输出结果如下所示：

```
1 abc
1 abc
abcdefabcdefabc
def
a b c
d e f
g h i
j  
 and 0
```

------

### printf的转义序列

| 序列  | 说明                                                         |
| ----- | ------------------------------------------------------------ |
| \a    | 警告字符，通常为ASCII的BEL字符                               |
| \b    | 后退                                                         |
| \c    | 抑制（不显示）输出结果中任何结尾的换行字符（只在%b格式指示符控制下的参数字符串中有效），而且，任何留在参数里的字符、任何接下来的参数以及任何留在格式字符串中的字符，都被忽略 |
| \f    | 换页（formfeed）                                             |
| \n    | 换行                                                         |
| \r    | 回车（Carriage return）                                      |
| \t    | 水平制表符                                                   |
| \v    | 垂直制表符                                                   |
| \\    | 一个字面上的反斜杠字符                                       |
| \ddd  | 表示1到3位数八进制值的字符。仅在格式字符串中有效             |
| \0ddd | 表示1到3位的八进制值字符                                     |

### 实例

```
$ printf "a string, no processing:<%s>\n" "A\nB"
a string, no processing:<A\nB>

$ printf "a string, no processing:<%b>\n" "A\nB"
a string, no processing:<A
B>

$ printf "qymua.com \a"
qymua.com $                  #不换行
```

## Shell test 命令

Shell中的 test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试。

------

### 数值测试

| 参数 | 说明           |
| ---- | -------------- |
| -eq  | 等于则为真     |
| -ne  | 不等于则为真   |
| -gt  | 大于则为真     |
| -ge  | 大于等于则为真 |
| -lt  | 小于则为真     |
| -le  | 小于等于则为真 |

实例演示：

```
num1=100
num2=100
if test $[num1] -eq $[num2]
then
    echo '两个数相等！'
else
    echo '两个数不相等！'
fi
```

输出结果：

```
两个数相等！
```

代码中的 [] 执行基本的算数运算，如：

```
#!/bin/bash

a=5
b=6

result=$[a+b] # 注意等号两边不能有空格
echo "result 为： $result"
```

结果为:

```
result 为： 11
```

------

### 字符串测试

| 参数      | 说明                     |
| --------- | ------------------------ |
| =         | 等于则为真               |
| !=        | 不相等则为真             |
| -z 字符串 | 字符串的长度为零则为真   |
| -n 字符串 | 字符串的长度不为零则为真 |

实例演示：

```
num1="ru1noob"
num2="runoob"
if test $num1 = $num2
then
    echo '两个字符串相等!'
else
    echo '两个字符串不相等!'
fi
```

输出结果：

```
两个字符串不相等!
```

------

### 文件测试

| 参数      | 说明                                 |
| --------- | ------------------------------------ |
| -e 文件名 | 如果文件存在则为真                   |
| -r 文件名 | 如果文件存在且可读则为真             |
| -w 文件名 | 如果文件存在且可写则为真             |
| -x 文件名 | 如果文件存在且可执行则为真           |
| -s 文件名 | 如果文件存在且至少有一个字符则为真   |
| -d 文件名 | 如果文件存在且为目录则为真           |
| -f 文件名 | 如果文件存在且为普通文件则为真       |
| -c 文件名 | 如果文件存在且为字符型特殊文件则为真 |
| -b 文件名 | 如果文件存在且为块特殊文件则为真     |

实例演示：

```
cd /bin
if test -e ./bash
then
    echo '文件已存在!'
else
    echo '文件不存在!'
fi
```

输出结果：

```
文件已存在!
```

另外，Shell还提供了与( -a )、或( -o )、非( ! )三个逻辑操作符用于将测试条件连接起来，其优先级为："!"最高，"-a"次之，"-o"最低。例如：

```
cd /bin
if test -e ./notFile -o -e ./bash
then
    echo '至少有一个文件存在!'
else
    echo '两个文件都不存在'
fi
```

输出结果：

```
至少有一个文件存在!
```

## Shell流程控制

### if 条件语句

简单的 if else-if else 的条件语句示例

```shell
#!/bin/bash
a=3;
b=9;
if [ $a -eq $b ]
then
   echo "a 等于 b"
elif [ $a -gt $b ]
then
   echo "a 大于 b"
else
   echo "a 小于 b"
fi
```

输出结果：

```
a 小于 b
```

相信大家通过上面的示例就已经掌握了 shell 编程中的 if 条件语句。不过，还要提到的一点是，不同于我们常见的 Java 以及 PHP 中的 if 条件语句，shell  if 条件语句中**不能包含空语句**也就是什么都不做的语句。

### for 循环语句

通过下面三个简单的示例认识 for 循环语句最基本的使用，实际上 for 循环语句的功能比下面你看到的示例展现的要大得多。

**输出当前列表中的数据：**

```shell
for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done
```

**产生 10 个随机数：**

```shell
#!/bin/bash
for i in {0..9};
do 
   echo $RANDOM;
done
```

**输出1到5:**

通常情况下 shell 变量调用需要加 $,但是 **for 的 (())** 中不需要,下面来看一个例子：

```shell
#!/bin/bash
for((i=1;i<=5;i++));do
    echo $i;
done;
```


### while 语句

**基本的 while 循环语句：**

```shell
#!/bin/bash
int=1
while(( $int<=5 ))
do
    echo $int
    let "int++"
done
```

**while循环可用于读取键盘信息：**

```shell
echo '按下 <CTRL-D> 退出'
echo -n '输入你最喜欢的电影: '
while read FILM
do
    echo "是的！$FILM 是一个好电影"
done
```

输出内容:

```
按下 <CTRL-D> 退出
输入你最喜欢的电影: 变形金刚
是的！变形金刚 是一个好电影
```

**无线循环：**

```shell
while true
do
    command
done
```

## Shell 函数

### 不带参数没有返回值的函数

```shell
#!/bin/bash
hello(){
    echo "这是我的第一个 shell 函数!"
}
echo "-----函数开始执行-----"
hello
echo "-----函数执行完毕-----"
```

输出结果：

```
-----函数开始执行-----
这是我的第一个 shell 函数!
-----函数执行完毕-----
```


### 有返回值的函数

**输入两个数字之后相加并返回结果：**

```shell
#!/bin/bash
funWithReturn(){
    echo "输入第一个数字: "
    read aNum
    echo "输入第二个数字: "
    read anotherNum
    echo "两个数字分别为 $aNum 和 $anotherNum !"
    return $(($aNum+$anotherNum))	
}
funWithReturn
echo "输入的两个数字之和为 $?"
```

输出结果：

```
输入第一个数字: 
1
输入第二个数字: 
2
两个数字分别为 1 和 2 !
输入的两个数字之和为 3
```

### 带参数的函数



```shell
#!/bin/bash
funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73

```

输出结果：

```
第一个参数为 1 !
第二个参数为 2 !
第十个参数为 10 !
第十个参数为 34 !.
第十一个参数为 73 !
参数总数有 11 个!
作为一个字符串输出所有参数 1 2 3 4 5 6 7 8 9 34 73 !

```

## Shell 输入/输出重定向

大多数 UNIX 系统命令从你的终端接受输入并将所产生的输出发送回到您的终端。一个命令通常从一个叫标准输入的地方读取输入，默认情况下，这恰好是你的终端。同样，一个命令通常将其输出写入到标准输出，默认情况下，这也是你的终端。

重定向命令列表如下：

| 命令            | 说明                                               |
| --------------- | -------------------------------------------------- |
| command > file  | 将输出重定向到 file。                              |
| command < file  | 将输入重定向到 file。                              |
| command >> file | 将输出以追加的方式重定向到 file。                  |
| n > file        | 将文件描述符为 n 的文件重定向到 file。             |
| n >> file       | 将文件描述符为 n 的文件以追加的方式重定向到 file。 |
| n >& m          | 将输出文件 m 和 n 合并。                           |
| n <& m          | 将输入文件 m 和 n 合并。                           |
| << tag          | 将开始标记 tag 和结束标记 tag 之间的内容作为输入。 |
| &> file         | 将正确和错误信息重定向到file                       |

> 需要注意的是文件描述符 0 通常是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

------

### 输出重定向

重定向一般通过在命令间插入特定的符号来实现。特别的，这些符号的语法如下所示:

```
command1 > file1
```

上面这个命令执行command1然后将输出的内容存入file1。

注意任何file1内的已经存在的内容将被新内容替代。如果要将新内容添加在文件末尾，请使用>>操作符。

实例

执行下面的 who 命令，它将命令的完整的输出重定向在用户文件中(users):

```
$ who > users
```

执行后，并没有在终端输出信息，这是因为输出已被从默认的标准输出设备（终端）重定向到指定的文件。

你可以使用 cat 命令查看文件内容：

```
$ cat users
_mbsetupuser console  Oct 31 17:35 
tianqixin    console  Oct 31 17:35 
tianqixin    ttys000  Dec  1 11:33 
```

输出重定向会覆盖文件内容，请看下面的例子：

```
$ echo "酋小木：qymua.com" > users
$ cat users
酋小木：qymua.com
$
```

如果不希望文件内容被覆盖，可以使用 >> 追加到文件末尾，例如：

```
$ echo "酋小木：qymua.com" >> users
$ cat users
酋小木：qymua.com
酋小木：qymua.com
$
```

------

### 输入重定向

和输出重定向一样，Unix 命令也可以从文件获取输入，语法为：

```
command1 < file1
```

这样，本来需要从键盘获取输入的命令会转移到文件读取内容。

注意：输出重定向是大于号(>)，输入重定向是小于号(<)。

### 实例

接着以上实例，我们需要统计 users 文件的行数,执行以下命令：

```
$ wc -l users
       2 users
```

也可以将输入重定向到 users 文件：

```
$  wc -l < users
       2 
```

注意：上面两个例子的结果不同：第一个例子，会输出文件名；第二个不会，因为它仅仅知道从标准输入读取内容。

```
command1 < infile > outfile
```

同时替换输入和输出，执行command1，从文件infile读取内容，然后将输出写入到outfile中。

### 重定向深入讲解

一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：

- 标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
- 标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
- 标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。

默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。

如果希望 stderr 重定向到 file，可以这样写：

```
$ command 2 > file
```

如果希望 stderr 追加到 file 文件末尾，可以这样写：

```
$ command 2 >> file
```

**2** 表示标准错误文件(stderr)。

如果希望将 stdout 和 stderr 合并后重定向到 file，可以这样写：

```
$ command > file 2>&1

或者

$ command >> file 2>&1
```

如果希望对 stdin 和 stdout 都重定向，可以这样写：

```
$ command < file1 >file2
```

command 命令将 stdin 重定向到 file1，将 stdout 重定向到 file2。

------

### Here Document

Here Document 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序。

它的基本的形式如下：

```
command << delimiter
    document
delimiter
```

它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command。

> 注意：
>
> - 结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。
> - 开始的delimiter前后的空格会被忽略掉。

### 实例

在命令行中通过 wc -l 命令计算 Here Document 的行数：

```
$ wc -l << EOF
    欢迎来到
    酋小木
    qymua.com
EOF
3          # 输出结果为 3 行
$
```

我们也可以将 Here Document 用在脚本中，例如：

```
#!/bin/bash
# author:酋小木
# url:qymua.com

cat << EOF
欢迎来到
酋小木
qymua.com
EOF
```

执行以上脚本，输出结果：

```
欢迎来到
酋小木
qymua.com
```

------

### /dev/null 文件

如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null：

```
$ command > /dev/null
```

/dev/null 是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，那么什么也读不到。但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"**禁止输出**"的效果。

如果希望屏蔽 stdout 和 stderr，可以这样写：

```
$ command > /dev/null 2>&1
```

> **注意：**0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

## Shell 文件包含

和其他语言一样，Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件。

Shell 文件包含的语法格式如下：

```
. filename   # 注意点号(.)和文件名中间有一空格

或

source filename
```

### 实例

创建两个 shell 脚本文件。

test1.sh 代码如下：

```
#!/bin/bash
# author:酋小木
# url:qymua.com

url="http://qymua.com"
```

test2.sh 代码如下：

```
#!/bin/bash
# author:酋小木
# url:qymua.com

#使用 . 号来引用test1.sh 文件
. ./test1.sh

# 或者使用以下包含文件代码
# source ./test1.sh

echo "酋小木官网地址：$url"
```

接下来，我们为 test2.sh 添加可执行权限并执行：

```
$ chmod +x test2.sh 
$ ./test2.sh 
酋小木官网地址：http://qymua.com
```

> **注：**被包含的文件 test1.sh 不需要可执行权限。