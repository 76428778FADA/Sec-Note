## 目录
  1. [基本操作](#1-basic-operations)  

    1.1. [文件操作](#11-file-operations)  
    1.2. [文本操作](#12-text-operations)  
    1.3. [目录操作](#13-directory-operations)  
    1.4. [SSH、系统信息和网络操作](#14-ssh-system-info--network-operations)  
    1.5. [进程监控操作](#15-process-monitoring-operations)
  2. [基本 shell 编程](#2-basic-shell-programming)  

    2.1. [变量](#21-variables)  
    2.2  [数组](#22-array)  
    2.3. [字符串替换](#23-string-substitution)  
    2.4. [函数](#24-functions)  
    2.5. [条件语句](#25-conditionals)  
    2.6. [循环语句](#26-loops)  
  3. [小技巧](#3-tricks)  
  4. [调试](#4-debugging)  


# 1. 基本操作

### a. `export`
输出所有的环境变量。 如果你想查看某个特定变量的值，用`echo $VARIABLE_NAME`
```bash
export
```
示例：
```bash
$ export
AWS_HOME=/Users/adnanadnan/.aws
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LESS=-R

$ echo $AWS_HOME
/Users/adnanadnan/.aws
```

### b. `whatis`
whatis 显示某个用户命令、系统调用或库函数的描述文档，或操作手册中存在的其他文档。
```bash
whatis something
```
示例：
```bash
$ whatis bash
bash (1)             - GNU Bourne-Again SHell
```

### c. `whereis`
whereis 查找可执行文件、源文件或者说明文档的位置，使用的是一个系统自动构建的数据库。
```bash
whereis name
```
示例：
```bash
$ whereis php
/usr/bin/php
```

### d. `which`
which 在环境变量 PATH 指定的所有文件夹中查找可执行文件的位置。它会打印出可执行文件的绝对路径。
```bash
which program_name 
```
示例：
```bash
$ which php
/c/xampp/php/php
```

### e. clear
清空窗口中的内容。

## 1.1. File Operations
<table>
   <tr>
      <td><a href="#a-cat">cat</a></td>
      <td><a href="#b-chmod">chmod</a></td>
      <td><a href="#c-chown">chown</a></td>
      <td><a href="#d-cp">cp</a></td>
      <td><a href="#e-diff">diff</a></td>
      <td><a href="#f-file">file</a></td>
      <td><a href="#g-find">find</a></td>
      <td><a href="#h-gunzip">gunzip</a></td>
      <td><a href="#i-gzcat">gzcat</a></td>
      <td><a href="#j-gzip">gzip</a></td>
      <td><a href="#k-head">head</a></td>
   </tr>
   <tr>
      <td><a href="#l-lpq">lpq</a></td>
      <td><a href="#m-lpr">lpr</a></td>
      <td><a href="#n-lprm">lprm</a></td>
      <td><a href="#o-ls">ls</a></td>
      <td><a href="#p-more">more</a></td>
      <td><a href="#q-mv">mv</a></td>
      <td><a href="#r-rm">rm</a></td>
      <td><a href="#s-tail">tail</a></td>
      <td><a href="#t-touch">touch</a></td>
   </tr>
</table>

### a. `cat`
在 UNIX 和 Linux 中，它有以下几种用途 
* 把文本文件显示在屏幕上
* 复制文本文件  
* 合并文本文件  
* 创建新的文本文件  
```bash
cat filename
cat file1 file2 
cat file1 file2 > newcombinedfile
cat < file1 > file2 #copy file1 to file2
```

### b. `chmod`
`chmod` 是 `change mod` 的意思，它用来改变文件或文件夹的读、写和执行权限。详细信息参见[这个链接](https://ss64.com/bash/chmod.html)
```bash
chmod -options filename
```

### c. `chown`
`chown` 是 `change owner` 的意思，它用来改变一个文件或者文件夹的所有者，所有者可以是一个用户或一个用户组。
```bash
chown -options user:group filename
```

### d. `cp`
把一个文件从一个位置复制到另外一个位置 
```bash
cp filename1 filename2
```
上面 `filename1` 是源文件位置， `filename2` 是目标位置（精确到文件名）。

### e. `diff` 
比对两个文件，输出他们的差异。
```bash
diff filename1 filename2
```

### f. `file`
检测文件类型 
```bash
file filename
```
示例：
```bash
$ file index.html
 index.html: HTML document, ASCII text
```
### g. `find`
在某个文件夹中用一定规则查找文件
```bash
find directory options pattern
```
示例：
```bash
$ find . -name README.md
$ find /home/user1 -name '*.png'
```

### h. `gunzip`
解压用 gzip 方法压缩的文件
```bash
gunzip filename
```

### i. `gzcat`
在不解压的情况下，查看 gzip 压缩过的文件 
```bash
gzcat filename
```

### j. `gzip`
压缩文件
```bash
gzip filename
```

### k. `head`
输出文件的前 10 行
```bash
head filename
```

### l. `lpq`
输出打印机列表  
```bash
lpq
```
示例：
```bash
$ lpq
Rank    Owner   Job     File(s)                         Total Size
active  adnanad 59      demo                            399360 bytes
1st     adnanad 60      (stdin)                         0 bytes
```

### m. `lpr`
打印一个文件  
```bash
lpr filename
```

### n. `lprm`
从打印机任务队列中移除某个任务  
```bash
lprm jobnumber
```

### o. `ls` 
列出当前文件夹下所有文件。`ls` 有很多选项：`-l` 以详细信息格式列出文件，详细信息包括文件实际大小，文件所有者，可查看者，以及最后修改时间。`-a` 列出所有文件，包括隐藏文件。更多信息参见[这个链接](https://ss64.com/bash/ls.html)
```bash
ls option
```
示例：
<pre>
$ ls -la
rwxr-xr-x   33 adnan  staff    1122 Mar 27 18:44 .
drwxrwxrwx  60 adnan  staff    2040 Mar 21 15:06 ..
-rw-r--r--@  1 adnan  staff   14340 Mar 23 15:05 .DS_Store
-rw-r--r--   1 adnan  staff     157 Mar 25 18:08 .bumpversion.cfg
-rw-r--r--   1 adnan  staff    6515 Mar 25 18:08 .config.ini
-rw-r--r--   1 adnan  staff    5805 Mar 27 18:44 .config.override.ini
drwxr-xr-x  17 adnan  staff     578 Mar 27 23:36 .git
-rwxr-xr-x   1 adnan  staff    2702 Mar 25 18:08 .gitignore
</pre>

### p. `more`  
输出一个文件的第一部分（用空格移动，按 q 退出）
```bash
more filename
```

### q. `mv`  
把一个文件从一个位置移动到另一个位置
```bash
mv filename1 filename2
```
上面`filename1` 是源文件的路径， `filename2`是目标路径。（都精确到文件名）

它也可以用来重命名文件
```bash
mv old_name new_name
```

### r. `rm`
删除一个文件
`rm: directory: is a directory`
如果想删除文件夹，需要添加 `r` 参数，这样会递归的删除文件夹内所有内容。可以使用 `f` 参数强制删除，略过确认环节。
```bash
rm filename
```

### s. `tail`
输出文件的最后 10 行。添加`-f`可以动态输出文件新添加的文本。  
```bash
tail filename
```

### t. `touch`
更新某个文件的访问和修改时间戳，如果文件不存在，将会被创建。
```bash
touch filename
```
示例：
```bash
$ touch trick.md
```

## 1.2. 文本操作

<table>
    <tr>
      <td><a href="#a-awk">awk</a></td>
      <td><a href="#b-cut">cut</a></td>
      <td><a href="#c-echo">echo</a></td>
      <td><a href="#d-egrep">egrep</a></td>
      <td><a href="#e-fgrep">fgrep</a></td>
      <td><a href="#f-fmt">fmt</a></td>
      <td><a href="#g-grep">grep</a></td>
      <td><a href="#h-nl">nl</a></td>
      <td><a href="#i-sed">sed</a></td>
      <td><a href="#j-sort">sort</a></td>
   </tr>
   <tr>
      <td><a href="#k-tr">tr</a></td>
      <td><a href="#l-uniq">uniq</a></td>
      <td><a href="#m-wc">wc</a></td>
   </tr>
</table>

### a. `awk`
awk 是文本操作最有用的命令。它按行处理整个文件，它默认用空格把每一行分隔成很多字段。最常用的语法是：

```bash
awk '/search_pattern/ { action_to_take_if_pattern_matches; }' file_to_parse
```

以 `/etc/passwd` 文件为例，该文件包含以下数据：
```
root:x:0:0:root:/root:/usr/bin/zsh
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
```
我们想从这个文件中过滤出每一行的 username 部分。`-F` 参数用来指明用来把行内内容分隔的分隔符。这个例子中，我们用`:`来分隔。`{ print $1 }` 意思是输出行内第一个匹配的字段。
```bash
awk -F':' '{ print $1 }' /etc/passwd
```
执行上面的命令之后，你会得到下面的输出。
```
root
daemon
bin
sys
sync
```
更多详细信息，参见[这个链接](https://www.cyberciti.biz/faq/bash-scripting-using-awk)


### b. `cut`
按行从文件中摘取文本并输出

*example.txt*
```bash
red riding hood went to the park to play
```

*用空格分隔每一行，并输出第2，7，9列*
```bash
cut -d " " -f2,7,9 example.txt
```
```bash
riding park play
```

### c. `echo`
输出命令之后的文本到标准输出或文件

*输出 "Hello World"*
```bash
echo Hello World
```
```bash
Hello World
```

*输出 "Hello World"，单词间用换行符分隔*
```bash
echo -ne "Hello\nWorld\n"
```
```bash
Hello
World
```

### d. `egrep`
输出文件中匹配指定模式的行，是 grep 命令的扩展模式，支持更多正则表达式（等同于 `grep -E`）。

*example.txt*
```bash
Lorem ipsum
dolor sit amet, 
consetetur
sadipscing elitr,
sed diam nonumy
eirmod tempor
invidunt ut labore
et dolore magna
aliquyam erat, sed
diam voluptua. At
vero eos et
accusam et justo
duo dolores et ea
rebum. Stet clita
kasd gubergren,
no sea takimata
sanctus est Lorem
ipsum dolor sit
amet.
```

*输出包含 Lorem 或 dolor 的行*
```bash
egrep '(Lorem|dolor)' example.txt
or
grep -E '(Lorem|dolor)' example.txt
```
```bash
Lorem ipsum
dolor sit amet,
et dolore magna
duo dolores et ea
sanctus est Lorem
ipsum dolor sit
```

### e. `fgrep`
输出文件中包含给定字符串的行，指定的模式将不被认做正则，而是字符串。（等同于：`grep -F`）

*example.txt*
```bash
Lorem ipsum
dolor sit amet,
consetetur
sadipscing elitr,
sed diam nonumy
eirmod tempor
foo (Lorem|dolor) 
invidunt ut labore
et dolore magna
aliquyam erat, sed
diam voluptua. At
vero eos et
accusam et justo
duo dolores et ea
rebum. Stet clita
kasd gubergren,
no sea takimata
sanctus est Lorem
ipsum dolor sit
amet.
```

* 输出在 example.txt 中包含字符串 `(Lorem|dolor)` 的所有行*
```bash
fgrep '(Lorem|dolor)' example.txt
or
grep -F '(Lorem|dolor)' example.txt
```
```bash
foo (Lorem|dolor) 
```

### f. `fmt`
简单的文本格式化工具

*example: example.txt (1 行)*
```bash
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
```

*把 example.txt 格式化为 20 个字符的宽度*
```bash
cat example.txt | fmt -w 20
```
```bash
Lorem ipsum
dolor sit amet,
consetetur
sadipscing elitr,
sed diam nonumy
eirmod tempor
invidunt ut labore
et dolore magna
aliquyam erat, sed
diam voluptua. At
vero eos et
accusam et justo
duo dolores et ea
rebum. Stet clita
kasd gubergren,
no sea takimata
sanctus est Lorem
ipsum dolor sit
amet.
```

### g. `grep`
在文件中查找文本。你可以用 grep 去查找匹配一个或多个正则表达式的文本行，然后输出这些行。 
```bash
grep pattern  filename
```
示例：
```bash
$ grep admin /etc/passwd
_kadmin_admin:*:218:-2:Kerberos Admin Service:/var/empty:/usr/bin/false
_kadmin_changepw:*:219:-2:Kerberos Change Password Service:/var/empty:/usr/bin/false
_krb_kadmin:*:231:-2:Open Directory Kerberos Admin Service:/var/empty:/usr/bin/false
```
你也可以通过 `-i` 参数强制忽略大小写。参数`-r`则被用来递归地查找指定文件夹下的所有文件，例如： 
```bash
$ grep -r admin /etc/
```
参数 `-w` 表示只查找单词。关于 `grep`的更多信息，参见[这个链接](https://www.cyberciti.biz/faq/grep-in-bash)

### h. `nl`
给文件添加行号并输出

*example.txt*
```bash
Lorem ipsum
dolor sit amet,
consetetur
sadipscing elitr,
sed diam nonumy
eirmod tempor
invidunt ut labore
et dolore magna
aliquyam erat, sed
diam voluptua. At
vero eos et
accusam et justo
duo dolores et ea
rebum. Stet clita
kasd gubergren,
no sea takimata
sanctus est Lorem
ipsum dolor sit
amet.
```

*给 example.txt 中的内容添加行号并输出*
```bash
nl -s". " example.txt 
```
```bash
     1. Lorem ipsum
     2. dolor sit amet,
     3. consetetur
     4. sadipscing elitr,
     5. sed diam nonumy
     6. eirmod tempor
     7. invidunt ut labore
     8. et dolore magna
     9. aliquyam erat, sed
    10. diam voluptua. At
    11. vero eos et
    12. accusam et justo
    13. duo dolores et ea
    14. rebum. Stet clita
    15. kasd gubergren,
    16. no sea takimata
    17. sanctus est Lorem
    18. ipsum dolor sit
    19. amet.
```

### i. `sed`
用于过滤和替换文本的流式编辑命令

*example.txt*
```bash
Hello This is a Test 1 2 3 4
```

*把 example.txt 所有空格替换为连字符并输出*
```bash
sed 's/ /-/g' example.txt
```
```bash
Hello-This-is-a-Test-1-2-3-4
```

*把所有数字替换为 "d"*
```bash
sed 's/[0-9]/d/g' example.txt
```
```bash
Hello This is a Test d d d d
```

### j. `sort`
对文件中的行进行排序

*example.txt*
```bash
f
b
c
g
a
e
d
```

*对 example.txt 中的行进行排序*
```bash
sort example.txt
```
```bash
a
b
c
d
e
f
g
```

*随机打乱已经排好序的 example.txt*（测试出现问题）// todo 
```bash
sort example.txt | sort -R
```
```bash
b
f
a
c
d
g
e
```

### k. `tr`
转换或删除字符

*example.txt*
```bash
Hello World Foo Bar Baz!
```

*把所有小写字母转换成大写字母*
```bash
cat example.txt | tr 'a-z' 'A-Z' 
```
```bash
HELLO WORLD FOO BAR BAZ!
```

*把所有的空格都转换为换行符*
```bash
cat example.txt | tr ' ' '\n'
```
```bash
Hello
World
Foo
Bar
Baz!
```

### l. `uniq`
统计或精简重复的行

*example.txt*
```bash
a
a
b
a
b
c
d
c
```

*输出 example.txt 中所有不重复的行(需要先进行排序, 否则相同行中间的行会被忽略)*
```bash
sort example.txt | uniq
```
```bash
a
b
c
d
```

*输出去重后的所有行，并显示不重复行中每一行在原文件中的重复次数*
```bash
sort example.txt | uniq -c
```
```bash
    3 a
    2 b
    2 c
    1 d
```

### m. `wc`
输出文件中的行、单词、字符个数。  
```bash
wc filename
```
示例：
```bash
$ wc demo.txt
7459   15915  398400 demo.txt
```
demo.txt中有 `7459` 行, `15915` 个单词以及 `398400` 个字符.

## 1.3. Directory Operations

<table>
   <tr>
      <td><a href="#a-cd">cd</a></td>
      <td><a href="#b-mkdir">mkdir</a></td>
      <td><a href="#c-pwd">pwd</a></td>
   </tr>
</table>

### a. `cd`
进入某个文件目录，执行：  
```bash
$ cd
```
会进入 `home` 目录。这个命令接受一个可选的目录名称的参数，指示要进入的目录。
```bash
cd dirname
```

### b. `mkdir`
创建一个新文件夹  
```bash
mkdir dirname
```

### c. `pwd`
显示当前所在的文件目录（绝对路径）  
```bash
pwd
```

## 1.4. SSH, System Info & Network Operations

<table>
   <tr>
      <td><a href="#a-bg">bg</a></td>
      <td><a href="#b-cal">cal</a></td>
      <td><a href="#c-date">date</a></td>
      <td><a href="#d-df">df</a></td>
      <td><a href="#e-dig">dig</a></td>
      <td><a href="#f-du">du</a></td>
      <td><a href="#g-fg">fg</a></td>
      <td><a href="#h-finger">finger</a></td>   
      <td><a href="#i-jobs">jobs</a></td>
      <td><a href="#j-last">last</a></td>
   </tr>
   <tr>
      <td><a href="#k-man">man</a></td>
      <td><a href="#l-passwd">passwd</a></td>
      <td><a href="#m-ping">ping</a></td>
      <td><a href="#n-ps">ps</a></td>
      <td><a href="#o-quota">quota</a></td>
      <td><a href="#p-scp">scp</a></td>
      <td><a href="#q-ssh">ssh</a></td>
      <td><a href="#r-top">top</a></td>
      <td><a href="#s-uname">uname</a></td>
      <td><a href="#t-uptime">uptime</a></td>
   </tr>
   <tr>
      <td><a href="#u-w">w</a></td>
      <td><a href="#v-wget">wget</a></td>
      <td><a href="#w-whoami">whoami</a></td>
      <td><a href="#x-whois">whois</a></td>
   </tr>
</table>

### a. `bg`
列出所有被停止或后台运行的任务，或将一个已停止的任务后台运行。

### b. `cal`
输出当前月份的日历

### c. `date`
输出当前日期和时间

### d. `df`
输出磁盘使用统计数据

### e. `dig`
输出某个域名的 DNS 信息  
```bash
dig domain
```

### f. `du`
输出某些文件或目录的硬盘使用情况。更多详细信息参见[这个链接](http://www.linfo.org/du.html)
```bash
du [option] [filename|directory]
```
Options:
- `-h` (人类可读) 把结果以 KB、 MB 、GB 为单位输出。
- `-s` (压缩总结) 输出一个目录总的磁盘空间占用情况，总结输出子目录的报告。

示例：
```bash
du -sh pictures
1.4M pictures
```

### g. `fg`
输出前台中最近运行的任务

### h. `finger`
输出某个用户的信息 
```bash
finger username
```
### i. `jobs`
列出在后台运行的任务，同时给出任务号

### j. `last`
列出特定用户的登录记录  
```bash
last yourUsername
```

### k. `man`
输出特定命令的使用手册
```bash
man command
```

### l. `passwd`
让当前登录的用户更改他的密码

### m. `ping`
ping 某个主机然后输出结果 
```bash
ping host
```

### n. `ps`
列出某个用户的所有进程  
```bash
ps -u yourusername
```

### o. `quota`
显示磁盘使用量和配额  
```bash
quota -v
```

### p. `scp`
在本地主机和远程主机之间或两个远程主机之间传输文件

*从本地主机复制文件到远程主机*
```bash
scp source_file user@host:directory/target_file
```
*从远程主机复制文件到本地主机*
```bash
scp user@host:directory/source_file target_file
scp -r user@host:directory/source_folder target_folder
```
这个命令也接受一个参数 `-P`，用来连接指定端口  
```bash
scp -P port user@host:directory/source_file target_file
```

### q. `ssh`
ssh(SSH 客户端)是一个用来登录到远程主机并执行命令的程序  
```bash
ssh user@host
```
这个命令也接受一个可选参数 `-p`，用来指定连接到特定的端口。
```bash
ssh -p port user@host
```

### r. `top`
动态展示所有活跃的进程

### s. `uname`
输出内核信息  
```bash
uname -a
```

### t. `uptime`
输出服务器运行了多长时间以及有多少个用户登录

### u. `w`
输出系统在线用户

### v. `wget`
下载文件  
```bash
wget file
```

### w. `whoami`
输出现在登录的用户的用户名

### x. `whois`
获取某个域名的 whois 信息  
```bash
whois domain
```

## 1.5. Process Monitoring Operations

<table>
   <tr>
      <td><a href="#a-kill">kill</a></td>
      <td><a href="#b-killall">killall</a></td>
      <td><a href="#c-&">&amp;</a></td>
      <td><a href="#d-nohup">nohup</a></td>
   </tr>
</table>

### a. `kill`
结束指定 PID 代表的进程 
```bash
kill PID
```

### b. `killall`
结束某个名字代表的所有进程
```bash
killall processname
```

### c. &
使得 `&` 之前的命令作为后台进程运行在 subshell 中
```bash
command &
```

### d. `nohup`
nohup 代表 `No Hang Up`，也即不要挂起。这条命令允许其它命令、进程或shell脚本在你退出shell之后继续在后台运行
```bash
nohup command
```
把它和 `&` 结合使用可以创建后台进程
```bash
nohup command &
```

# 2. Basic Shell Programming


在 bash 脚本文件中的第一行被叫做 `shebang`。这一行决定了脚本可以像一个独立的可执行文件一样执行，而不用在终端之前输入`sh`,`bash`,`python`,`php`等。

```bash
#!/bin/bash
```

## 2.1. Variables

在 bash 中创建变量跟其它语言相似。没有变量类型，bash 中的变量可以保存一个数字、一个字符、一个字符串等等。同时无需提前声明变量，给变量赋值会直接创建变量。

示例：
```bash
str="hello world"
```

上面一行创建了一个变量 `str` 然后把 "hello world" 赋值给它。通过在变量名之前添加`$`符号，可以取到变量里面保存的值。

示例：
```bash
echo $str   # hello world
```
## 2.2. Array
像其它语言一样，bash 也有数组类型。bash 中的数组是一个保存着很多值的变量，数组的长度没有限制，下标也是从 0 开始。在 bash 中有好几种方法创建一个数组，如下所示。

Examples:
```bash
array[0] = val
array[1] = val
array[2] = val
array=([2]=val [0]=val [1]=val)
array=(val val val)
```
使用如下语法获得数组特定位置的值：

```bash
${array[i]}     # i是数组下标
```

如果没有指定数组下标，默认返回第一个元素。想知道数组中有多少个元素，使用下面的语法：

```bash
${#array[@]}
```

Bash 也支持三元运算符，如下面的例子所示：

```bash
${varname:-word}    # 如果 varname 存在而且不为 null，返回它的值，否则返回 word
${varname:=word}    # 如果 varname 存在而且不为 null，返回它的值，否则把word赋值给它并且返回 word
${varname:+word}    # 如果 varname 存在而且不为 null，返回 word，否则返回 null
${varname:offset:length}    # 它返回 $varname 的子字符串，从 offset 处开始，长度为 length
```

## 2.3 String Substitution

通过下面的语法来学习字符串相关操作

```bash
${variable#pattern}         # 如果 pattern 匹配变量值的起始部分，删除匹配 pattern 的最短的部分，然后返回剩余的
${variable##pattern}        # 如果 pattern 匹配变量值的起始部分，删除匹配 pattern 的最长的部分，然后返回剩余的
${variable%pattern}         # 如果 pattern 匹配变量值的结束部分，删除匹配 pattern 的最短的部分，然后返回剩余的
${variable%%pattern}        # 如果 pattern 匹配变量值的结束部分，删除匹配 pattern 的最长的部分，然后返回剩余的
${variable/pattern/string}  # 把变量值中匹配 pattern 的最长的部分替换为 string，只替换第一个匹配的部分
${variable//pattern/string} # 把变量值中匹配 pattern 的最长的部分替换为 string，全局进行替换
${#varname}     # 返回变量值作为一个字符串的长度
```

## 2.4. Functions
As in almost any programming language, you can use functions to group pieces of code in a more logical way or practice the divine art of recursion. Declaring a function is just a matter of writing . Calling a function is just like calling another program, you just write its name.
就像在其它编程语言中那样，您可以使用 function 来以更合乎逻辑的方式聚合代码，或实现递归的神圣艺术。声明一个 function 只需要写下`function my_func { my_code }` ，调用 function 就像调用另外的程序一样，使用方法名称即可。

```bash
function name() {
    shell commands
}
```

示例：
```bash
#!/bin/bash
function hello {
   echo world!
}
hello

function say {
    echo $1
}
say "hello world!"
```

当你运行上面例子中的 hello 方法时，它会输出 "world!"。上面的两个方法 `hello` 和 `say` 一模一样的， `say` 有一些不同，这个方法会打印出它接受到的第一个参数。方法中的参数，跟脚本语言中的处理方式一样。

## 2.5. Conditionals

bash 中的条件语句跟其他编程语言类似。条件语句有很多种形式，就像最常见的基本形式是 `if` 表达式 `then` 语句，代表如果表达式为真，则执行响应的语句。

```bash
if [expression]; then
    will execute only if expression is true
else
    will execute if expression is false
fi
```

有些时候如果条件语句变得太复杂，你可以用 `case statements` 来完成相同的条件判断功能。

```bash
case expression in
    pattern1 )
        statements ;;
    pattern2 )
        statements ;;
    ...
esac
```

Expression Examples:

```bash
statement1 && statement2  # 两个语句都为真
statement1 || statement2  # 至少一个语句为真

str1=str2       # str1 匹配 str2
str1!=str2      # str1 不匹配 str2
str1<str2       # str1 小于 str2
str1>str2       # str1 大于 str2
-n str1         # str1 不是 null (长度大于 0)
-z str1         # str1 是 null (长度为 0)

-a file         # 文件存在
-d file         # 文件存在而且是目录
-e file         # 文件存在，跟 -a 一样
-f file         # 文件存在，而且是常规文件（不是目录或者其他特殊类型的文件）
-r file         # 你有读权限
-s file         # 文件存在而且不为空
-w file         # 你有写权限
-x file         # 你对文件有执行权限，如果 file 是目录的话，你对它有搜索权限
-N file         # 从上次读之后文件被修改过
-O file         # 你是文件所有者
-G file         # 文件的 group ID 跟你的 group ID （或之一，如果你在很多分组里）相同

file1 -nt file2     # file1 比 file2 更新
file1 -ot file2     # file1 比 file2 更老

-lt     # 小于
-le     # 小于等于
-eq     # 等于
-ge     # 大于等于
-gt     # 大于
-ne     # 不等于
```

## 2.6. Loops

bash 中有三种类型的循环。`for`, `while` 和 `until`。

不同的 `for` 语法：
```bash
for x := 1 to 10 do
begin
  statements
end

for name [in list]
do
  statements that can use $name
done

for (( initialisation ; ending condition ; update ))
do
  statements...
done
```

`while` 语法:
```bash
while condition; do
  statements
done
```

`until` 语法:
```bash
until condition; do
  statements
done
```

# 3. Tricks

## 设置别名
执行 `nano ~/.bash_profile` 来打开 `bash_profile`。
> alias dockerlogin='ssh www-data@adnan.local -p2222'  # 在 .bash_profile 中设置别名

## 快速进入某个目录
nano ~/.bashrc
> export hotellogs="/workspace/hotel-api/storage/logs"

```bash
source ~/.bashrc
cd $hotellogs
```

## 跳出陷阱

通过执行清理语句使得你的脚本更有鲁棒性

```bash
function finish {
  # 在这里执行清理语句，例如，杀掉所有 fork 的进程。
  jobs -p | xargs kill
}
trap finish EXIT
```

## 保存环境变量

当你在 shell 中执行  `export FOO = BAR`, 环境变量只在当前 shell 和它的子 shell 中存在，如果想在将来能够永久使用这个环境变量，只需要在 `~/.bash_profile` 文件后面添加要执行的命令即可。
```bash
echo export FOO=BAR >> ~/.bash_profile
```

## 访问你的脚本

通过在 home 目录下创建 bin 文件夹， 你可以很容易的访问你的脚本，`mkdir ~/bin` 之后，在 bin 目录里面的所有脚本都能在任何别的目录下访问到。

如果还是不能访问，把下面的代码添加到 `~/.bash_profile` 文件中，然后执行`source ~/.bash_profile`。
```bash
    # 如果用户的私有 bin 目录存在的话，把它添加到 PATH 变量中
    if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
    fi
```

# 4. 调试
你可以很容易地通过传递不同的参数给 `bash` 命令来调试脚本。例如， `-n` 将会只检查脚本的语法错误而不执行脚本。 `-v` 将会在命令执行前输出它们。 `-x` 将会在命令行处理之后输出命令。

```bash
bash -n scriptname
bash -v scriptname
bash -x scriptname
```

## 贡献

- 报告问题 [How to](https://help.github.com/articles/creating-an-issue/)
- 提交改进型的合并请求 [How to](https://help.github.com/articles/about-pull-requests/)
- 帮助传播

## Translation
- [Turkish | Türkçe](https://github.com/omergulen/bash-guide)
- [Japanese | 日本語](https://github.com/itooww/bash-guide)

## License

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)