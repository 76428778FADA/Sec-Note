### 前期准备

！！碰巧看到了完美匹配自己电脑型号的EFI引导文件，抓住体验Macos的机会，折腾起来~

黑果指南有它就够了=> https://github.com/daliansky/Hackintosh 

工具/文件：

- macOS High Sierra 10.13.6(17G2112) Installer with Clover 4606 - 四叶草系统镜像
- GP62M 7RD 10.13.4 EFI - 黑果社区下载(CLOVER/)
- DiskGenius - 磁盘分区工具
- balenaEtcher-Portable - 烧制系统U盘
- MultiBeast-High-Sierra-Edition - 驱动安装(类似驱动精灵) 不一定可以顺利完美驱动
- Clover Configurator - 四叶草黑苹果必备
- cloverefiboot-themes - clover主题更换(推荐Minimalism)
- EasyUEFI - 修改UEFI引导
- 其他还有准备一些，但是没用到

**开始安装黑苹果前检查以下条件是否满足**

* win10系统最好独立在一个硬盘
* 另一块硬盘分区连续，且有足够空间压缩空闲分区安装Macos
* 安装黑苹果是在windows系统已经存在的情况下，形成双系统，如果不需要双系统可忽略
* 重要文件都已经备份

### 制作系统安装盘

U盘大小不小于8G！

下载需要安装的系统镜像(dmg),使用balenaEtcher直接烧制，大概需要半个小时左右

烧制结束后直接替换完美适配的EFI文件了，当然第一次安装可以尝试，万一可以呢

~~EFI文件的最低要求(目的)可以让我们成功进入系统安装程序~~

最后这里需要使用DiskGenius工具对U盘的引导文件进行修改，具体操作不多说

![image-20200429195456451](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472450452.png)

不一定是完全替换，主要将CLOVER文件夹替换，其他就看情况了，没遇到过

这个文件夹的文件结构可以直接去黑果小兵那里查，四叶草官网应该也有

由于不需要手动修改配置这些东西，因此没有深入了解，折腾需适度DX

![image-20200429160626196](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472450445.png)

### 磁盘分区设置

还是使用DiskGenius在准备安装Macos的硬盘上新建一个EFI分区，大小推荐1G，不小于200MB

接着在系统的计算机管理-磁盘管理，压缩一个空闲分区=>新建分区=>不格式化卷(这是重点)

### 安装黑苹果

前面准备的工具需要提前拷到其他硬盘备用

重启电脑，设置U盘引导，具体这里也不多说

只要EFI文件OK，就可以正常加载出安装界面，会重启几次，需要一点时间

进入系统安装界面后，需要使用磁盘管理工具，抹掉刚刚新建的未格式化的分区，新建一个APFS分区(SSD硬盘推荐)

开始安装的时候遇到了联网验证时间的问题，因为安装的是10.13版本，修改系统时间断网后顺利安装

到这里正常已经进入系统，安装成果了

### 驱动修复

为了少折腾，这是底线

我找到了三个工具对黑苹果体验这波折腾做个收尾

MultiBeast-High-Sierra-Edition - 驱动安装(类似驱动精灵)

Clover Configurator - 四叶草黑苹果必备工具

cloverefiboot-themes - clover主题更换(推荐Minimalism)

具体使用可以参考网络教程

驱动方面-万能声卡不一定不能用，可以尝试，至少我没有爆音现象

四卡能用就可以满足基本体验，所以不折腾~

![image-20200429162043493](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472450453.png)

### Macos使用心得

想记录的只有俩个点，目前遇到的比较重要的问题，一些好用的工具已经记录在了Tools目录

#### 可读可写磁盘挂载(可以直接使用mounty，但体验不一样)

Macos磁盘挂载路径:系统盘/Volunmes 是隐藏文件夹

设置默认挂载为可读可写磁盘：

![image-20200429162700315](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472450454.png)

设置如上，不多说，重启就生效，不用每次使用mounty工具挂载，可把常用的磁盘写进去

#### Macos终端体验

推荐直接用iterm2

对一些主题的兼容性比较好

要做这些操作需要配置以下环境：

- git
- xcode command line IDE
- homebrew

具体参考网络教程

和自带终端做个对比：

![image-20200429163006778](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472450455.png)



### 2020/5/10 更新

为了不让自己天天想着10.15的随航功能，看着自己的ipad，心里渐渐热了起来，于是乎，成功！搞定，参考GL72系列的EFI，修改了亿点点，删除和替换了部分驱动，如今已经接近完美了！！！

EFI也已上传，亲测可以直升10.15.4最新版本