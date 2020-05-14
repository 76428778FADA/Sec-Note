- [一 从认识操作系统开始](#一-从认识操作系统开始)
  - [1.1 操作系统简介](#11-操作系统简介)
  - [1.2 操作系统简单分类](#12-操作系统简单分类)
- [二 初探Linux](#二-初探linux)
  - [2.1 Linux简介](#21-linux简介)
  - [2.2 Linux诞生简介](#22-linux诞生简介)
  - [2.3 Linux的分类](#23-linux的分类)
- [三 Linux文件系统概览](#三-linux文件系统概览)
  - [3.1 Linux文件系统简介](#31-linux文件系统简介)
  - [3.2 文件类型与目录结构](#32-文件类型与目录结构)
- [四 Linux基本命令](#四-linux基本命令)
  - [4.1 目录切换命令](#41-目录切换命令)
  - [4.2 目录的操作命令（增删改查）](#42-目录的操作命令增删改查)
  - [4.3 文件的操作命令（增删改查）](#43-文件的操作命令增删改查)
  - [4.4 压缩文件的操作命令](#44-压缩文件的操作命令)
  - [4.5 Linux的权限命令](#45-linux的权限命令)
  - [4.6 Linux 用户管理](#46-linux-用户管理)
  - [4.7 Linux系统用户组的管理](#47-linux系统用户组的管理)
  - [4.8 其他常用命令](#48-其他常用命令)

> 学习Linux之前，我们先来简单的认识一下操作系统。

## 一 从认识操作系统开始

### 1.1 操作系统简介

我通过以下四点介绍什么是操作系统：

- **操作系统（Operation System，简称OS）是管理计算机硬件与软件资源的程序，是计算机系统的内核与基石；**
- **操作系统本质上是运行在计算机上的软件程序 ；**
- **为用户提供一个与系统交互的操作界面 ；**
- **操作系统分内核与外壳（我们可以把外壳理解成围绕着内核的应用程序，而内核就是能操作硬件的程序）。**

![操作系统分内核与外壳](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627563.jpg)
### 1.2 操作系统简单分类

1. **Windows:** 目前最流行的个人桌面操作系统 ，不做多的介绍，大家都清楚。

2. **Unix：** 最早的多用户、多任务操作系统 .按照操作系统的分类，属于分时操作系统。Unix 大多被用在服务器、工作站，现在也有用在个人计算机上。它在创建互联网、计算机网络或客户端/服务器模型方面发挥着非常重要的作用。

  ![Unix](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627437.jpg)

3. **Linux:** Linux是一套免费使用和自由传播的类Unix操作系统.Linux存在着许多不同的Linux版本，但它们都使用了 **Linux内核** 。Linux可安装在各种计算机硬件设备中，比如手机、平板电脑、路由器、视频游戏控制台、台式计算机、大型机和超级计算机。严格来讲，Linux这个词本身只表示Linux内核，但实际上人-们已经习惯了用Linux来形容整个基于Linux内核，并且使用GNU 工程各种工具和数据库的操作系统。

![Linux](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627903.jpg)


## 二 初探Linux

### 2.1 Linux简介

我们上面已经介绍到了Linux，我们这里只强调三点。
- **类Unix系统：** Linux是一种自由、开放源码的类似Unix的操作系统 
- **Linux内核：** 严格来说，Linux这个词本身只表示Linux内核 
- **Linux之父：** 一个编程领域的传奇式人物。他是Linux内核的最早作者，随后发起了这个开源项目，担任Linux内核的首要架构师与项目协调者，是当今世界最著名的电脑程序员、黑客之一。他还发起了Git这个开源项目，并为主要的开发者。

![Linux](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627437.jpg)

### 2.2 Linux诞生简介

- 1991年，芬兰的业余计算机爱好者Linus Torvalds编写了一款类似Minix的系统（基于微内核架构的类Unix操作系统）被ftp管理员命名为Linux 加入到自由软件基金的GNU计划中; 
- Linux以一只可爱的企鹅作为标志，象征着敢作敢为、热爱生活。 


### 2.3 Linux的分类

**Linux根据原生程度，分为两种：**

1. **内核版本：** Linux不是一个操作系统，严格来讲，Linux只是一个操作系统中的内核。内核是什么？内核建立了计算机软件与硬件之间通讯的平台，内核提供系统服务，比如文件管理、虚拟内存、设备I/O等；
2. **发行版本：** 一些组织或公司在内核版基础上进行二次开发而重新发行的版本。Linux发行版本有很多种（ubuntu和CentOS用的都很多，初学建议选择CentOS），如下图所示：
![Linux发行版本](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627887.jpg)


## 三 Linux文件系统概览

### 3.1 Linux文件系统简介

**在Linux操作系统中，所有被操作系统管理的资源，例如网络接口卡、磁盘驱动器、打印机、输入输出设备、普通文件或是目录都被看作是一个文件。**

也就是说在LINUX系统中有一个重要的概念：**一切都是文件**。其实这是UNIX哲学的一个体现，而Linux是重写UNIX而来，所以这个概念也就传承了下来。在UNIX系统中，把一切资源都看作是文件，包括硬件设备。UNIX系统把每个硬件都看成是一个文件，通常称为设备文件，这样用户就可以用读写文件的方式实现对硬件的访问。


### 3.2 文件类型与目录结构

**Linux支持5种文件类型 ：**
![文件类型](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472628321.jpg)

**Linux的目录结构如下：**

Linux文件系统的结构层次鲜明，就像一棵倒立的树，最顶层是其根目录：
![Linux的目录结构](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627903.jpg)

**常见目录说明：**

- **/bin：** 存放二进制可执行文件(ls、cat、mkdir等)，常用命令一般都在这里；
- **/etc：** 存放系统管理和配置文件；
- **/home：**存放所有用户文件的根目录，是用户主目录的基点，比如用户user的主目录就是/home/user，可以用~user表示；
- **/usr ：**用于存放系统应用程序；
- **/opt：** 额外安装的可选应用程序包所放置的位置。一般情况下，我们可以把tomcat等都安装到这里；
- **/proc：**虚拟文件系统目录，是系统内存的映射。可直接访问这个目录来获取系统信息；
- **/root：** 超级用户（系统管理员）的主目录（特权阶级^o^）；
- **/sbin:**  存放二进制可执行文件，只有root才能访问。这里存放的是系统管理员使用的系统级别的管理命令和程序。如ifconfig等；
- **/dev：** 用于存放设备文件；
- **/mnt：** 系统管理员安装临时文件系统的安装点，系统提供这个目录是让用户临时挂载其他的文件系统；
- **/boot：**存放用于系统引导时使用的各种文件；
- **/lib ：**存放着和系统运行相关的库文件 ；
- **/tmp：** 用于存放各种临时文件，是公用的临时文件存储点；
- **/var：** 用于存放运行时需要改变数据的文件，也是某些大文件的溢出区，比方说各种服务的日志文件（系统启动日志等。）等；
- **/lost+found：**  这个目录平时是空的，系统非正常关机而留下“无家可归”的文件（windows下叫什么.chk）就在这里。


## 四 Linux基本命令

下面只是给出了一些比较常用的命令。推荐一个Linux命令快查网站，非常不错，大家如果遗忘某些命令或者对某些命令不理解都可以在这里得到解决。

Linux命令大全：[http://man.linuxde.net/](http://man.linuxde.net/)
### 4.1 目录切换命令

- **`cd usr`：**   切换到该目录下usr目录  
- **`cd ..（或cd../）`：**  切换到上一层目录 
- **`cd /`：**   切换到系统根目录  
- **`cd ~`：**   切换到用户主目录 
- **`cd -`：**   切换到上一个操作所在目录

### 4.2 目录的操作命令(增删改查)

1. **`mkdir 目录名称`：** 增加目录
2. **`ls或者ll`**（ll是ls -l的别名，ll命令可以看到该目录下的所有目录和文件的详细信息）：查看目录信息
3. **`find 目录 参数`：** 寻找目录（查）

    示例：
    
    - 列出当前目录及子目录下所有文件和文件夹: `find .`
    - 在`/home`目录下查找以.txt结尾的文件名:`find /home -name "*.txt"`
    - 同上，但忽略大小写: `find /home -iname "*.txt"`
    - 当前目录及子目录下查找所有以.txt和.pdf结尾的文件:`find . \( -name "*.txt" -o -name "*.pdf" \)`或`find . -name "*.txt" -o -name "*.pdf" `
    
4. **`mv 目录名称 新目录名称`：** 修改目录的名称（改）

   注意：mv的语法不仅可以对目录进行重命名而且也可以对各种文件，压缩包等进行  重命名的操作。mv命令用来对文件或目录重新命名，或者将文件从一个目录移到另一个目录中。后面会介绍到mv命令的另一个用法。
5. **`mv 目录名称 目录的新位置`：**  移动目录的位置---剪切（改）
  
    注意：mv语法不仅可以对目录进行剪切操作，对文件和压缩包等都可执行剪切操作。另外mv与cp的结果不同，mv好像文件“搬家”，文件个数并未增加。而cp对文件进行复制，文件个数增加了。
6. **`cp -r 目录名称 目录拷贝的目标位置`：** 拷贝目录（改），-r代表递归拷贝 
   
    注意：cp命令不仅可以拷贝目录还可以拷贝文件，压缩包等，拷贝文件和压缩包时不  用写-r递归
7. **`rm [-rf] 目录`:** 删除目录（删）
   
    注意：rm不仅可以删除目录，也可以删除其他文件或压缩包，为了增强大家的记忆，  无论删除任何目录或文件，都直接使用`rm -rf` 目录/文件/压缩包


### 4.3 文件的操作命令(增删改查)

1. **`touch 文件名称`:**  文件的创建（增）
2. **`cat/more/less/tail 文件名称`** 文件的查看（查）
    - **`cat`：** 查看显示文件内容
    - **`more`：** 可以显示百分比，回车可以向下一行， 空格可以向下一页，q可以退出查看
    - **`less`：** 可以使用键盘上的PgUp和PgDn向上 和向下翻页，q结束查看
    - **`tail-10` ：** 查看文件的后10行，Ctrl+C结束
    
   注意：命令 tail -f 文件 可以对某个文件进行动态监控，例如tomcat的日志文件，  会随着程序的运行，日志会变化，可以使用tail -f catalina-2016-11-11.log 监控 文 件的变化 
3. **`vim 文件`：**  修改文件的内容（改）

   vim编辑器是Linux中的强大组件，是vi编辑器的加强版，vim编辑器的命令和快捷方式有很多，但此处不一一阐述，大家也无需研究的很透彻，使用vim编辑修改文件的方式基本会使用就可以了。

   **在实际开发中，使用vim编辑器主要作用就是修改配置文件，下面是一般步骤：**
   
    vim 文件------>进入文件----->命令模式------>按i进入编辑模式----->编辑文件  ------->按Esc进入底行模式----->输入：wq/q! （输入wq代表写入内容并退出，即保存；输入q!代表强制退出不保存。）
4. **`rm -rf 文件`：** 删除文件（删）

    同目录删除：熟记 `rm -rf` 文件 即可
    
### 4.4 压缩文件的操作命令

**1）打包并压缩文件：**

Linux中的打包文件一般是以.tar结尾的，压缩的命令一般是以.gz结尾的。

而一般情况下打包和压缩是一起进行的，打包并压缩后的文件的后缀名一般.tar.gz。
命令：**`tar -zcvf 打包压缩后的文件名 要打包压缩的文件`**
其中：

  z：调用gzip压缩命令进行压缩

  c：打包文件

  v：显示运行过程

  f：指定文件名

比如：假如test目录下有三个文件分别是：aaa.txt bbb.txt ccc.txt，如果我们要打包test目录并指定压缩后的压缩包名称为test.tar.gz可以使用命令：**`tar -zcvf test.tar.gz aaa.txt bbb.txt ccc.txt`或：`tar -zcvf test.tar.gz       /test/`**


**2）解压压缩包：**

命令：tar [-xvf] 压缩文件

其中：x：代表解压

示例：

1 将/test下的test.tar.gz解压到当前目录下可以使用命令：**`tar -xvf test.tar.gz`**

2 将/test下的test.tar.gz解压到根目录/usr下:**`tar -xvf test.tar.gz -C /usr`**（- C代表指定解压的位置）


### 4.5 Linux的权限命令

 操作系统中每个文件都拥有特定的权限、所属用户和所属组。权限是操作系统用来限制资源访问的机制，在Linux中权限一般分为读(readable)、写(writable)和执行(excutable)，分为三组。分别对应文件的属主(owner)，属组(group)和其他用户(other)，通过这样的机制来限制哪些用户、哪些组可以对特定的文件进行什么样的操作。通过 **`ls -l`** 命令我们可以  查看某个目录下的文件或目录的权限

示例：在随意某个目录下`ls -l`

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627529.jpg)

第一列的内容的信息解释如下：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627529.jpg)

> 下面将详细讲解文件的类型、Linux中权限以及文件有所有者、所在组、其它组具体是什么？


**文件的类型：**

- d： 代表目录
- -： 代表文件
- l： 代表软链接（可以认为是window中的快捷方式）


**Linux中权限分为以下几种：**

- r：代表权限是可读，r也可以用数字4表示
- w：代表权限是可写，w也可以用数字2表示
- x：代表权限是可执行，x也可以用数字1表示

**文件和目录权限的区别：**

 对文件和目录而言，读写执行表示不同的意义。

 对于文件：

| 权限名称      |   可执行操作  |
| :-------- | --------:|
|  r | 可以使用cat查看文件的内容 |
|w  |   可以修改文件的内容 |
| x     |    可以将其运行为二进制文件 |

 对于目录：

| 权限名称      |   可执行操作  |
| :-------- | --------:|
|  r | 可以查看目录下列表 |
|w  |   可以创建和删除目录下文件 |
| x     |    可以使用cd进入目录 |


**需要注意的是超级用户可以无视普通用户的权限，即使文件目录权限是000，依旧可以访问。**
**在linux中的每个用户必须属于一个组，不能独立于组外。在linux中每个文件有所有者、所在组、其它组的概念。**

- **所有者**

  一般为文件的创建者，谁创建了该文件，就天然的成为该文件的所有者，用ls ‐ahl命令可以看到文件的所有者 也可以使用chown 用户名  文件名来修改文件的所有者 。
- **文件所在组**

  当某个用户创建了一个文件后，这个文件的所在组就是该用户所在的组 用ls ‐ahl命令可以看到文件的所有组 也可以使用chgrp  组名  文件名来修改文件所在的组。 
- **其它组**

  除开文件的所有者和所在组的用户外，系统的其它用户都是文件的其它组 

> 我们再来看看如何修改文件/目录的权限。

**修改文件/目录的权限的命令：`chmod`**

示例：修改/test下的aaa.txt的权限为属主有全部权限，属主所在的组有读写权限，
其他用户只有读的权限

**`chmod u=rwx,g=rw,o=r aaa.txt`**

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472627887.jpg)

上述示例还可以使用数字表示：

chmod 764 aaa.txt


**补充一个比较常用的东西:**

假如我们装了一个zookeeper，我们每次开机到要求其自动启动该怎么办？

1. 新建一个脚本zookeeper
2. 为新建的脚本zookeeper添加可执行权限，命令是:`chmod +x zookeeper`
3. 把zookeeper这个脚本添加到开机启动项里面，命令是：` chkconfig --add  zookeeper`
4. 如果想看看是否添加成功，命令是：`chkconfig --list`


### 4.6 Linux 用户管理

Linux系统是一个多用户多任务的分时操作系统，任何一个要使用系统资源的用户，都必须首先向系统管理员申请一个账号，然后以这个账号的身份进入系统。

用户的账号一方面可以帮助系统管理员对使用系统的用户进行跟踪，并控制他们对系统资源的访问；另一方面也可以帮助用户组织文件，并为用户提供安全性保护。

**Linux用户管理相关命令:**
- `useradd 选项 用户名`:添加用户账号
- `userdel 选项 用户名`:删除用户帐号
- `usermod 选项 用户名`:修改帐号
- `passwd 用户名`:更改或创建用户的密码
- `passwd -S 用户名` :显示用户账号密码信息
- `passwd -d 用户名`:  清除用户密码

useradd命令用于Linux中创建的新的系统用户。useradd可用来建立用户帐号。帐号建好之后，再用passwd设定帐号的密码．而可用userdel删除帐号。使用useradd指令所建立的帐号，实际上是保存在/etc/passwd文本文件中。

passwd命令用于设置用户的认证信息，包括用户密码、密码过期时间等。系统管理者则能用它管理系统用户的密码。只有管理者可以指定用户名称，一般用户只能变更自己的密码。


### 4.7 Linux系统用户组的管理

每个用户都有一个用户组，系统可以对一个用户组中的所有用户进行集中管理。不同Linux 系统对用户组的规定有所不同，如Linux下的用户属于与它同名的用户组，这个用户组在创建用户时同时创建。

用户组的管理涉及用户组的添加、删除和修改。组的增加、删除和修改实际上就是对/etc/group文件的更新。

**Linux系统用户组的管理相关命令:**
- `groupadd 选项 用户组` :增加一个新的用户组
- `groupdel 用户组`:要删除一个已有的用户组
- `groupmod 选项 用户组` : 修改用户组的属性


### 4.8 其他常用命令

- **`pwd`：** 显示当前所在位置
- **`grep 要搜索的字符串 要搜索的文件 --color`：** 搜索命令，--color代表高亮显示
- **`ps -ef`/`ps -aux`：** 这两个命令都是查看当前系统正在运行进程，两者的区别是展示格式不同。如果想要查看特定的进程可以使用这样的格式：**`ps aux|grep redis`** （查看包括redis字符串的进程），也可使用 `pgrep redis -a`。

  注意：如果直接用ps（（Process Status））命令，会显示所有进程的状态，通常结合grep命令查看某进程的状态。
- **`kill -9 进程的pid`：** 杀死进程（-9 表示强制终止。）

  先用ps查找进程，然后用kill杀掉
- **网络通信命令：**
    - 查看当前系统的网卡信息：ifconfig
    - 查看与某台机器的连接情况：ping 
    - 查看当前系统的端口使用：netstat -an
-  **net-tools 和 iproute2 ：**
    `net-tools`起源于BSD的TCP/IP工具箱，后来成为老版本Linux内核中配置网络功能的工具。但自2001年起，Linux社区已经对其停止维护。同时，一些Linux发行版比如Arch Linux和CentOS/RHEL 7则已经完全抛弃了net-tools，只支持`iproute2`。linux ip命令类似于ifconfig，但功能更强大，旨在替代它。更多详情请阅读[如何在Linux中使用IP命令和示例](https://linoxide.com/linux-command/use-ip-command-linux)
- **`shutdown`：**  `shutdown -h now`： 指定现在立即关机；`shutdown +5 "System will shutdown after 5 minutes"`：指定5分钟后关机，同时送出警告信息给登入用户。
- **`reboot`：**  **`reboot`：**  重开机。**`reboot -w`：** 做个重开机的模拟（只有纪录并不会真的重开机）。

## 五 linux yum 命令

yum（ Yellow dog Updater, Modified）是一个在Fedora和RedHat以及SUSE中的Shell前端软件包管理器。

基於RPM包管理，能够从指定的服务器自动下载RPM包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装。

yum提供了查找、安装、删除某一个、一组甚至全部软件包的命令，而且命令简洁而又好记。

### yum 语法

```
yum [options] [command] [package ...]
[options] [command] [package ...]
```

- **options：**可选，选项包括-h（帮助），-y（当安装过程提示选择全部为"yes"），-q（不显示安装的过程）等等。
- **command：**要进行的操作。
- **package**操作的对象。

------

### yum常用命令

- 1.列出所有可更新的软件清单命令：yum check-update
- 2.更新所有软件命令：yum update
- 3.仅安装指定的软件命令：yum install <package_name>
- 4.仅更新指定的软件命令：yum update <package_name>
- 5.列出所有可安裝的软件清单命令：yum list
- 6.删除软件包命令：yum remove <package_name>
- 7.查找软件包 命令：yum search <keyword>
- 8.清除缓存命令:
  - yum clean packages: 清除缓存目录下的软件包
  - yum clean headers: 清除缓存目录下的 headers
  - yum clean oldheaders: 清除缓存目录下旧的 headers
  - yum clean, yum clean all (= yum clean packages; yum clean oldheaders) :清除缓存目录下的软件包及旧的headers

#### 实例 1

安装 pam-devel

```
[root@www ~]# yum install pam-develroot@www ~]# yum install pam-devel
Setting up Install ProcessSetting up Install Process
Parsing package install argumentsParsing package install arguments
Resolving Dependencies  <==先检查软件的属性相依问题Resolving Dependencies  <==先检查软件的属性相依问题
--> Running transaction check--> Running transaction check
---> Package pam-devel.i386 0:0.99.6.2-4.el5 set to be updated---> Package pam-devel.i386 0:0.99.6.2-4.el5 set to be updated
--> Processing Dependency: pam = 0.99.6.2-4.el5 for package: pam-devel--> Processing Dependency: pam = 0.99.6.2-4.el5 for package: pam-devel
--> Running transaction check--> Running transaction check
---> Package pam.i386 0:0.99.6.2-4.el5 set to be updated---> Package pam.i386 0:0.99.6.2-4.el5 set to be updated
filelists.xml.gz          100% |=========================| 1.6 MB    00:05.xml.gz          100% |=========================| 1.6 MB    00:05
filelists.xml.gz          100% |=========================| 138 kB    00:00.xml.gz          100% |=========================| 138 kB    00:00
-> Finished Dependency Resolution-> Finished Dependency Resolution
……(省略)……(省略)
```

#### 实例 2

移除 pam-devel

```
[root@www ~]# yum remove pam-develroot@www ~]# yum remove pam-devel
Setting up Remove ProcessSetting up Remove Process
Resolving Dependencies  <==同样的，先解决属性相依的问题Resolving Dependencies  <==同样的，先解决属性相依的问题
--> Running transaction check--> Running transaction check
---> Package pam-devel.i386 0:0.99.6.2-4.el5 set to be erased---> Package pam-devel.i386 0:0.99.6.2-4.el5 set to be erased
--> Finished Dependency Resolution--> Finished Dependency Resolution

Dependencies ResolvedDependencies Resolved

==========================================================================================================================================================
 Package                 Arch       Version          Repository        SizePackage                 Arch       Version          Repository        Size
==========================================================================================================================================================
Removing:Removing:
 pam-devel               i386       0.99.6.2-4.el5   installed         495 k-devel               i386       0.99.6.2-4.el5   installed         495 k

Transaction SummaryTransaction Summary
==========================================================================================================================================================
Install      0 Package(s)Install      0 Package(s)
Update       0 Package(s)Update       0 Package(s)
Remove       1 Package(s)  <==还好，并没有属性相依的问题，单纯移除一个软件Remove       1 Package(s)  <==还好，并没有属性相依的问题，单纯移除一个软件

Is this ok [y/N]: yIs this ok [y/N]: y
Downloading Packages:Downloading Packages:
Running rpm_check_debugRunning rpm_check_debug
Running Transaction TestRunning Transaction Test
Finished Transaction TestFinished Transaction Test
Transaction Test SucceededTransaction Test Succeeded
Running TransactionRunning Transaction
  Erasing   : pam-devel                    ######################### [1/1]Erasing   : pam-devel                    ######################### [1/1]

Removed: pam-devel.i386 0:0.99.6.2-4.el5Removed: pam-devel.i386 0:0.99.6.2-4.el5
Complete!Complete!
```

#### 实例 3

利用 yum 的功能，找出以 pam 为开头的软件名称有哪些？

```
[root@www ~]# yum list pam*root@www ~]# yum list pam*
Installed PackagesInstalled Packages
pam.i386                  0.99.6.2-3.27.el5      installed.i386                  0.99.6.2-3.27.el5      installed
pam_ccreds.i386           3-5                    installed.i386           3-5                    installed
pam_krb5.i386             2.2.14-1               installed.i386             2.2.14-1               installed
pam_passwdqc.i386         1.0.2-1.2.2            installed.i386         1.0.2-1.2.2            installed
pam_pkcs11.i386           0.5.3-23               installed.i386           0.5.3-23               installed
pam_smb.i386              1.1.7-7.2.1            installed.i386              1.1.7-7.2.1            installed
Available Packages <==底下则是『可升级』的或『未安装』的Available Packages <==底下则是『可升级』的或『未安装』的
pam.i386                  0.99.6.2-4.el5         base.i386                  0.99.6.2-4.el5         base
pam-devel.i386            0.99.6.2-4.el5         base-devel.i386            0.99.6.2-4.el5         base
pam_krb5.i386             2.2.14-10              base.i386             2.2.14-10              base
```

------

### 国内 yum 源

网易（163）yum源是国内最好的yum源之一 ，无论是速度还是软件版本，都非常的不错。

将yum源设置为163 yum，可以提升软件包安装和更新的速度，同时避免一些常见软件版本无法找到。

### 安装步骤

首先备份/etc/yum.repos.d/CentOS-Base.repo

```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
/etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
```

下载对应版本 repo 文件, 放入 /etc/yum.repos.d/ (操作前请做好相应备份)

- [CentOS5](http://mirrors.163.com/.help/CentOS5-Base-163.repo) ：http://mirrors.163.com/.help/CentOS5-Base-163.repo
- [CentOS6](http://mirrors.163.com/.help/CentOS6-Base-163.repo) ：http://mirrors.163.com/.help/CentOS6-Base-163.repo
- [CentOS7](http://mirrors.163.com/.help/CentOS7-Base-163.repo) ：http://mirrors.163.com/.help/CentOS7-Base-163.repo

```
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo://mirrors.163.com/.help/CentOS6-Base-163.repo
mv CentOS6-Base-163.repo CentOS-Base.repoCentOS6-Base-163.repo CentOS-Base.repo
```

运行以下命令生成缓存

```
yum clean all
yum makecache
```

除了网易之外，国内还有其他不错的 yum 源，比如中科大和搜狐。

中科大的 yum 源，安装方法查看：<https://lug.ustc.edu.cn/wiki/mirrors/help/centos>

sohu 的 yum 源安装方法查看: <http://mirrors.sohu.com/help/centos.html>

## 六 Linux 磁盘管理

Linux磁盘管理好坏直接关系到整个系统的性能问题。

Linux磁盘管理常用三个命令为df、du和fdisk。

- df：列出文件系统的整体磁盘使用量
- du：检查磁盘空间使用量
- fdisk：用于磁盘分区

------

### df

df命令参数功能：检查文件系统的磁盘空间占用情况。可以利用该命令来获取硬盘被占用了多少空间，目前还剩下多少空间等信息。

语法：

```
df [-ahikHTm] [目录或文件名]
```

选项与参数：

- -a ：列出所有的文件系统，包括系统特有的 /proc 等文件系统；
- -k ：以 KBytes 的容量显示各文件系统；
- -m ：以 MBytes 的容量显示各文件系统；
- -h ：以人们较易阅读的 GBytes, MBytes, KBytes 等格式自行显示；
- -H ：以 M=1000K 取代 M=1024K 的进位方式；
- -T ：显示文件系统类型, 连同该 partition 的 filesystem 名称 (例如 ext3) 也列出；
- -i ：不用硬盘容量，而以 inode 的数量来显示

#### 实例 1

将系统内所有的文件系统列出来！

```
[root@www ~]# df
Filesystem      1K-blocks      Used Available Use% Mounted on
/dev/hdc2         9920624   3823112   5585444  41% /
/dev/hdc3         4956316    141376   4559108   4% /home
/dev/hdc1          101086     11126     84741  12% /boot
tmpfs              371332         0    371332   0% /dev/shm
```

在 Linux 底下如果 df 没有加任何选项，那么默认会将系统内所有的 (不含特殊内存内的文件系统与 swap) 都以 1 Kbytes 的容量来列出来！

#### 实例 2

将容量结果以易读的容量格式显示出来

```
[root@www ~]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hdc2             9.5G  3.7G  5.4G  41% /
/dev/hdc3             4.8G  139M  4.4G   4% /home
/dev/hdc1              99M   11M   83M  12% /boot
tmpfs                 363M     0  363M   0% /dev/shm
```

#### 实例 3

将系统内的所有特殊文件格式及名称都列出来

```
[root@www ~]# df -aT
Filesystem    Type 1K-blocks    Used Available Use% Mounted on
/dev/hdc2     ext3   9920624 3823112   5585444  41% /
proc          proc         0       0         0   -  /proc
sysfs        sysfs         0       0         0   -  /sys
devpts      devpts         0       0         0   -  /dev/pts
/dev/hdc3     ext3   4956316  141376   4559108   4% /home
/dev/hdc1     ext3    101086   11126     84741  12% /boot
tmpfs        tmpfs    371332       0    371332   0% /dev/shm
none   binfmt_misc         0       0         0   -  /proc/sys/fs/binfmt_misc
sunrpc  rpc_pipefs         0       0         0   -  /var/lib/nfs/rpc_pipefs
```

#### 实例 4

将 /etc 底下的可用的磁盘容量以易读的容量格式显示

```
[root@www ~]# df -h /etc
Filesystem            Size  Used Avail Use% Mounted on
/dev/hdc2             9.5G  3.7G  5.4G  41% /
```

------

### du

Linux du命令也是查看使用空间的，但是与df命令不同的是Linux du命令是对文件和目录磁盘使用的空间的查看，还是和df命令有一些区别的，这里介绍Linux du命令。

语法：

```
du [-ahskm] 文件或目录名称
```

选项与参数：

- -a ：列出所有的文件与目录容量，因为默认仅统计目录底下的文件量而已。
- -h ：以人们较易读的容量格式 (G/M) 显示；
- -s ：列出总量而已，而不列出每个各别的目录占用容量；
- -S ：不包括子目录下的总计，与 -s 有点差别。
- -k ：以 KBytes 列出容量显示；
- -m ：以 MBytes 列出容量显示；

#### 实例 1

列出目前目录下的所有文件容量

```
[root@www ~]# du
8       ./test4     <==每个目录都会列出来
8       ./test2
....中间省略....
12      ./.gconfd   <==包括隐藏文件的目录
220     .           <==这个目录(.)所占用的总量
```

直接输入 du 没有加任何选项时，则 du 会分析当前所在目录的文件与目录所占用的硬盘空间。

#### 实例 2

将文件的容量也列出来

```
[root@www ~]# du -a
12      ./install.log.syslog   <==有文件的列表了
8       ./.bash_logout
8       ./test4
8       ./test2
....中间省略....
12      ./.gconfd
220     .
```

#### 实例 3

检查根目录底下每个目录所占用的容量

```
[root@www ~]# du -sm /*
7       /bin
6       /boot
.....中间省略....
0       /proc
.....中间省略....
1       /tmp
3859    /usr     <==系统初期最大就是他了啦！
77      /var
```

通配符 * 来代表每个目录。

与 df 不一样的是，du 这个命令其实会直接到文件系统内去搜寻所有的文件数据。

------

#### fdisk

fdisk 是 Linux 的磁盘分区表操作工具。

语法：

```
fdisk [-l] 装置名称
```

选项与参数：

- -l ：输出后面接的装置所有的分区内容。若仅有 fdisk -l 时， 则系统将会把整个系统内能够搜寻到的装置的分区均列出来。

#### 实例 1

列出所有分区信息

```
[root@AY120919111755c246621 tmp]# fdisk -l

Disk /dev/xvda: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

    Device Boot      Start         End      Blocks   Id  System
/dev/xvda1   *           1        2550    20480000   83  Linux
/dev/xvda2            2550        2611      490496   82  Linux swap / Solaris

Disk /dev/xvdb: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x56f40944

    Device Boot      Start         End      Blocks   Id  System
/dev/xvdb2               1        2610    20964793+  83  Linux
```

#### 实例 2

找出你系统中的根目录所在磁盘，并查阅该硬盘内的相关信息

```
[root@www ~]# df /            <==注意：重点在找出磁盘文件名而已
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hdc2              9920624   3823168   5585388  41% /

[root@www ~]# fdisk /dev/hdc  <==仔细看，不要加上数字喔！
The number of cylinders for this disk is set to 5005.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help):     <==等待你的输入！
```

输入 m 后，就会看到底下这些命令介绍

```
Command (m for help): m   <== 输入 m 后，就会看到底下这些命令介绍
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition            <==删除一个partition
   l   list known partition types
   m   print this menu
   n   add a new partition           <==新增一个partition
   o   create a new empty DOS partition table
   p   print the partition table     <==在屏幕上显示分割表
   q   quit without saving changes   <==不储存离开fdisk程序
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit  <==将刚刚的动作写入分割表
   x   extra functionality (experts only)
```

离开 fdisk 时按下 `q`，那么所有的动作都不会生效！相反的， 按下`w`就是动作生效的意思。

```
Command (m for help): p  <== 这里可以输出目前磁盘的状态

Disk /dev/hdc: 41.1 GB, 41174138880 bytes        <==这个磁盘的文件名与容量
255 heads, 63 sectors/track, 5005 cylinders      <==磁头、扇区与磁柱大小
Units = cylinders of 16065 * 512 = 8225280 bytes <==每个磁柱的大小

   Device Boot      Start         End      Blocks   Id  System
/dev/hdc1   *           1          13      104391   83  Linux
/dev/hdc2              14        1288    10241437+  83  Linux
/dev/hdc3            1289        1925     5116702+  83  Linux
/dev/hdc4            1926        5005    24740100    5  Extended
/dev/hdc5            1926        2052     1020096   82  Linux swap / Solaris
# 装置文件名 启动区否 开始磁柱    结束磁柱  1K大小容量 磁盘分区槽内的系统

Command (m for help): q
```

想要不储存离开吗？按下 q 就对了！不要随便按 w 啊！

使用 `p` 可以列出目前这颗磁盘的分割表信息，这个信息的上半部在显示整体磁盘的状态。

------

### 磁盘格式化

磁盘分割完毕后自然就是要进行文件系统的格式化，格式化的命令非常的简单，使用 `mkfs`（make filesystem） 命令。

语法：

```
mkfs [-t 文件系统格式] 装置文件名
```

选项与参数：

- -t ：可以接文件系统格式，例如 ext3, ext2, vfat 等(系统有支持才会生效)

#### 实例 1

查看 mkfs 支持的文件格式

```
[root@www ~]# mkfs[tab][tab]
mkfs         mkfs.cramfs  mkfs.ext2    mkfs.ext3    mkfs.msdos   mkfs.vfat
```

按下两个[tab]，会发现 mkfs 支持的文件格式如上所示。

#### 实例 2

将分区 /dev/hdc6（可指定你自己的分区） 格式化为 ext3 文件系统：

```
[root@www ~]# mkfs -t ext3 /dev/hdc6
mke2fs 1.39 (29-May-2006)
Filesystem label=                <==这里指的是分割槽的名称(label)
OS type: Linux
Block size=4096 (log=2)          <==block 的大小配置为 4K 
Fragment size=4096 (log=2)
251392 inodes, 502023 blocks     <==由此配置决定的inode/block数量
25101 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=515899392
16 block groups
32768 blocks per group, 32768 fragments per group
15712 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912

Writing inode tables: done
Creating journal (8192 blocks): done <==有日志记录
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 34 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
# 这样就创建起来我们所需要的 Ext3 文件系统了！简单明了！
```

------

### 磁盘检验

fsck（file system check）用来检查和维护不一致的文件系统。

若系统掉电或磁盘发生问题，可利用fsck命令对文件系统进行检查。

语法：

```
fsck [-t 文件系统] [-ACay] 装置名称
```

选项与参数：

- -t : 给定档案系统的型式，若在 /etc/fstab 中已有定义或 kernel 本身已支援的则不需加上此参数
- -s : 依序一个一个地执行 fsck 的指令来检查
- -A : 对/etc/fstab 中所有列出来的 分区（partition）做检查
- -C : 显示完整的检查进度
- -d : 打印出 e2fsck 的 debug 结果
- -p : 同时有 -A 条件时，同时有多个 fsck 的检查一起执行
- -R : 同时有 -A 条件时，省略 / 不检查
- -V : 详细显示模式
- -a : 如果检查有错则自动修复
- -r : 如果检查有错则由使用者回答是否修复
- -y : 选项指定检测每个文件是自动输入yes，在不确定那些是不正常的时候，可以执行 # fsck -y 全部检查修复。

#### 实例 1

查看系统有多少文件系统支持的 fsck 命令：

```
[root@www ~]# fsck[tab][tab]
fsck         fsck.cramfs  fsck.ext2    fsck.ext3    fsck.msdos   fsck.vfat
```

#### 实例 2

强制检测 /dev/hdc6 分区:

```
[root@www ~]# fsck -C -f -t ext3 /dev/hdc6 
fsck 1.39 (29-May-2006)
e2fsck 1.39 (29-May-2006)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
vbird_logical: 11/251968 files (9.1% non-contiguous), 36926/1004046 blocks
```

如果没有加上 -f 的选项，则由于这个文件系统不曾出现问题，检查的经过非常快速！若加上 -f 强制检查，才会一项一项的显示过程。

------

### 磁盘挂载与卸除

Linux 的磁盘挂载使用 `mount` 命令，卸载使用 `umount` 命令。

磁盘挂载语法：

```
mount [-t 文件系统] [-L Label名] [-o 额外选项] [-n]  装置文件名  挂载点
```

#### 实例 1

用默认的方式，将刚刚创建的 /dev/hdc6 挂载到 /mnt/hdc6 上面！

```
[root@www ~]# mkdir /mnt/hdc6
[root@www ~]# mount /dev/hdc6 /mnt/hdc6
[root@www ~]# df
Filesystem           1K-blocks      Used Available Use% Mounted on
.....中间省略.....
/dev/hdc6              1976312     42072   1833836   3% /mnt/hdc6
```

磁盘卸载命令 `umount` 语法：

```
umount [-fn] 装置文件名或挂载点
```

选项与参数：

- -f ：强制卸除！可用在类似网络文件系统 (NFS) 无法读取到的情况下；
- -n ：不升级 /etc/mtab 情况下卸除。

卸载/dev/hdc6

```
[root@www ~]# umount /dev/hdc6     
```



