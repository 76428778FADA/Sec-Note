> 作为一个白帽子，使用github的唯一目的是记录自己的研究项目，存放学习笔记，备份资料等等。对协同开发的需求不大，简单使用Git的几个命令就可以上传本地文件到远程服务器，很多人说很繁琐，喜欢使用GUI版本的github for Desktop,那么这就看个人喜好了~接下来的内容仅适合同我情况差不多的人阅读! 

详细的学习教程-->[菜鸟教程 for Git](http://www.runoob.com/git/git-tutorial.html) 

<!-- more -->

## Git和github的关系

`git`: 是分布式版本控制工具（Version control）,它可在本地建立仓库,你写的代码的各个版本都可以存着 ;

`github`: 是一个面向开源及私有软件项目的托管平台，相当于网上仓库,你写的代码的各个版本都可以存着;

`历史渊源`：Git比GitHub出生的早。事件回到2005年，有个公司不允许linux系统继续免费使用它们的版本控制软件了，然后linux系统创始人Torvalds一气之下花了10天时间创造了Git（第一个版本），并且开源给所有人免费试用。3年后，Tom Preston使用Git作为版本控制软件创建了http://Github.com ，一个专门托管代码并且可以实现版本控制的网站。Tom之所以把网站叫做Github，是因为其核心部分版本控制是用Git来处理的。但是 为什么有人回复调侃Github是全球最大男性交友网站呢？那是因为Github的注册用户大都是男生，而且彼此之间可以相互关注（类似于微博）

## Git概览

所有命令前都要加 `git`，如表中的`init`是指 `git init`。<br> 点击命令可直接跳转至本文第一次使用的地方。<br>
以下命令都在命令行里执行。

### 1、个人本地使用

|     行为     |         命令         | 备注                                       |
| :----------: | :------------------: | :----------------------------------------- |
|    初始化    |         init         | 在本地的当前目录里初始化git仓库            |
|              |     clone [url]      | 从网络上某个地址拷贝仓库(repository)到本地 |
| 查看当前状态 |        status        | 查看当前仓库的状态。                       |
|   查看不同   |         diff         | 查看当前状态和最新的commit之间不同的地方   |
|   添加文件   |        add -A        | 这算是相当通用的了。在commit之前要先add    |
|     提交     | commit -m "提交信息" | 提交信息最好能体现更改了什么               |
| 查看提交记录 |         log          | 查看当前版本及之前的commit记录             |

### 2、个人使用远程仓库

|      行为      |                  命令                  | 备注                                     |
| :------------: | :------------------------------------: | :--------------------------------------- |
|   设置用户名   | config --global user.name "你的用户名" |                                          |
|    设置邮箱    | config --global user.email "你的邮箱"  |                                          |
|  生成ssh key   |    ssh-keygen -t rsa -C "你的邮箱"     | 这条命令前面不用加git                    |
|  添加远程仓库  |     remote add origin 你复制的地址     | 设置origin                               |
| 上传并指定默认 |         push -u origin master          | 指定默认主机，以后push默认上传到origin上 |
| 提交到远程仓库 |                  push                  | 将当前分支增加的commit提交到远程仓库     |
| 从远程仓库同步 |                  pull                  | 获取远程仓库的commit                     |

可以使用一张图直观地看出以上主要命令对仓库的影响

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146081.jpg)

图片引用自：[Git introduction for CVS/SVN/TFS users](http://blog.podrezo.com/git-introduction-for-cvssvntfs-users/)

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146269.jpg)

图片引用自：[工作区和暂存区 - 廖雪峰的官方网站](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013745374151782eb658c5a5ca454eaa451661275886c6000) （做了点修改）

对照查看两张图：

> workspace 即工作区，逻辑上是本地计算机，还没添加到repository的状态；
> staging 即版本库中的stage，是暂存区。修改已经添加进repository，但还没有作为commit提交，类似于缓存；
> Local repository 即版本库中master那个地方。到这一步才算是成功生成一个新版本；
> Remote repository 则是远程仓库。用来将本地仓库上传到网络，可以用于备份、共享、合作。本文将使用Github作为远程仓库的例子。


## Git 安装

### Git for windows

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146773.jpg)

 安装包可以到[官方网站](https://git-for-windows.github.io/)下载，或者在[github](https://github.com/git-for-windows/git/releases)下载。如果下载不下来，可以把链接复制下来用迅雷下载。如果用迅雷下载不放心，在下载完后去在github下载的那个地方查看SHA-256值，并和下载的文件对比，如果值一样就可以放心使用。<br>
 安装的时候一路点击`Next`就行了。<br>
 刚安装完打开后，窗口比较小。如果不太习惯，可以把它改大一些。<br>
 1、首先移到窗口右下角边缘，出现箭头后把窗口拉大。
 2、点击窗口顶部左边的图标 -> Options... -> Window -> Current size -> OK
     这样以后打开窗口都会是调整后的大小。

> Git for Windows从[2.8.0](https://github.com/git-for-windows/git/releases/tag/v2.8.0.windows.1)版本开始，默认添加环境变量，所以环境变量部分就不用再手动配置了。

### Git for Linux

Git 的工作需要调用 curl，zlib，openssl，expat，libiconv 等库的代码，所以需要先安装这些依赖工具。

在有 yum 的系统上（比如 Fedora）或者有 apt-get 的系统上（比如 Debian 体系），可以用下面的命令安装：

各 Linux 系统可以使用其安装包管理工具（apt-get、yum 等）进行安装：

`Debian/Ubuntu` Git 安装命令为：

```
$ apt-get install libcurl4-gnutls-dev libexpat1-dev gettext \
  libz-dev libssl-dev

$ apt-get install git

$ git --version
git version 1.8.1.2
```

### 用户信息配置

配置个人的用户名称和电子邮件地址：

```
$ git config --global user.name "Qymua"
$ git config --global user.email "test@Qymua.com"
```

如果用了 **--global** 选项，那么更改的配置文件就是位于你用户主目录下的那个，以后你所有的项目都会默认使用这里配置的用户信息。

如果要在某个特定的项目中使用其他名字或者电邮，只要去掉 --global 选项重新配置即可，新的设定保存在当前项目的 .git/config 文件里。

## Git for github

> 到这里表示已经可以开始使用Git上传项目到github了

### 添加ssh key

由于你的本地 Git 仓库和 GitHub 仓库之间的传输是通过SSH加密的，所以我们需要配置验证信息：

使用以下命令生成 SSH Key：

```
$ ssh-keygen -t rsa -C "youremail@example.com"
```

后面的*your_email@youremail.com*改为你在 Github 上注册的邮箱，之后会要求确认路径和输入密码，我们这使用默认的一路回车就行。成功的话会在 ~/ 下生成 .ssh 文件夹，进去，打开 **id_rsa.pub**，复制里面的 **key**。

回到 github 上，进入 Account => Settings（账户配置）。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146306.jpg)

左边选择 **SSH and GPG keys**，然后点击 **New SSH key** 按钮,title 设置标题，可以随便填，粘贴在你电脑上生成的 key。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146422.jpg)

添加成功后为了验证是否成功，输入以下命令：

```
$ ssh -T git@github.com
Hi tianqixin! You've successfully authenticated, but GitHub does not provide shell access.
```

### 新建仓库

这里不再说明如何创建了，只介绍下相应选项的用途

Repository name: 仓库名称

Description(可选): 仓库描述介绍

Public, Private : 仓库权限（公开共享，私有或指定合作者）

Initialize this repository with a README: 添加一个README.md

gitignore: 不需要进行版本管理的仓库类型，对应生成文件.gitignore

license: 证书类型，对应生成文件LICENSE
​
### 开始上传

 1、在本地创建一个版本库（即文件夹），通过git init把它变成Git仓库；

 2、把项目复制到这个文件夹里面，再通过`git add . `把项目添加到仓库；

 3、再通过git commit -m "注释内容"把项目提交到仓库；

 4、通过git remote add origin https://github.com/用户名/项目名.git 将本地仓库和远程仓库进行关联；

 5、最后通过git push -u origin master把本地仓库的项目推送到远程仓库（也就是Github）上；

 *由于新建的远程仓库是空的，所以要加上-u这个参数，等远程仓库里面有了内容之后，下次再从本地库上传内容的时候只需下面这样就可以了：*

```
$ git push origin master
```

（若新建远程仓库的时候自动创建了README文件会报错，解决办法看下面）。

 这是由于你新创建的那个仓库里面的README文件不在本地仓库目录中，这时我们可以通过以下命令先将内容合并以下：

```
$ git pull --rebase origin master
```

### 工作区迁移

1、在新环境下配置好Git；

2、通过git init把它变成Git仓库；

3、git clone [url] 克隆仓库到本地；

4、git add . 添加项目到仓库（缓存区）；

5、通过git remote add origin https://github.com/用户名/项目名.git 将本地仓库和远程仓库进行关联；

6、其实到这里已经迁移完成，主要是下载到本地，添加Git仓库后，再把项目同步到本地仓库上

## 拓展
**change time:2019-6-29**
近期为了使用gitbook写电子书，开始重新接触github pages、github badge，也因此不再将本博客托管至github，只托管于coding
### github pages
https://pages.github.com/
感觉教程也很多，没什么细节操作,就不多废话了,需要的时候折腾下，不做开发不是很需要这么规范
### github badge
单纯为了好看的，没用实际用途
用一些通用的小图标来描述项目相关信息确实不失为一种很棒的选择

GitHub 项目的 README.md 中可以添加徽章（Badge）对项目进行标记和说明，这些好看的小图标不仅简洁美观，而且还包含了清晰易读的信息。
徽标主要由图片和对应的链接（当然，你可以不填）组成，徽标图片的话一般由左半部分的名称和右半部分的值组成。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146597.png)

GitHub 徽标的官方网站是 [shields.io](https://shields.io/)
例如：自定义徽标

``` 
https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg
```
![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473146391.png)

## 本文涉及的术语

- Version Control（版本控制）:任何一个能够让你了解文件的历史，以及该文件的发展进程的系统。
- Git：一个版本控制程序，通过对变更进行注释，以创建一个易于遍历的系统历史。
- Commit（提交）：在指定时间点对系统差异进行的注释 “快照”。
- Local（本地）：指任意时刻工作时正在使用的电脑。
- Remote（远程）： 指某个联网的位置。
- Repository (仓库，简称 repo)：配置了Git超级权限的特定文件夹，包含了你的项目或系统相关的所有文件。
- Github：获取本地提交历史记录，并进行远程存储，以便你可以从任何计算机访问这些记录。
- Pushing（推送）：取得本地Git提交（以及相关的所有工作），然后将其上传到在线Github。
- Pulling（拉取）：从在线的Github上获取最新的提交记录，然后合并到本地电脑上。
- Master (branch)：主分支，提交历史 “树”的 “树干”，包含所有已审核的内容/代码。
- Feature branch（功能分支/特性分支）：一个基于主分支的独立的位置，在再次并入到主分支之前，你可以在这里安全地写工作中的新任务。
- Pull Request（发布请求）：一个 Github 工具，允许用户轻松地查看某功能分支的更改 （the difference或 “diff”），同时允许用户在该分支合并到主分支之前对其进行讨论和调整。
- Merging（合并）：该操作指获取功能分支的提交，加入到主分支提交历史的顶部。
- Checking out（切换）：该操作指从一个分支切换到另一个分支。
