> 一直想找个适合学习二进制的稳定的第二系统，windows是不可能不要的，配合VMware+linux子系统，还是棒棒的！就是不太稳定，譬如不小心中病毒之类的，爱折腾的我，找个备用系统还是很有必要的。只是为了更专注的学习这块内容，鄙人想着折腾一下。从deepin到kubuntu，还是更青睐基于arch的manjaro，什么都有的AUR，KDE桌面兼容得最好的发行版本，内核共存，版本回退，还有各种IT技术党管用的操作技巧，将这一切综合在一起，就它了！当然ubuntu大法也很不错，win底下还是经常用虚拟机开着的昂。 
<!-- more -->

## 准备工作

1.下载镜像

[清华大学开源镜像站](https://mirrors.tuna.tsinghua.edu.cn/#)

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472605734.jpg)

2.压缩空闲分区（建议使用固态）

3.制作启动盘

有两种方式制作启动盘，利用diskimage选择ios镜像，直接制作

你也可以选择[rufus]( http://rufus.akeo.ie/)  选择**DD**模式写入

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472604863.jpg)

## 开始安装

我只简单罗列一些安装过程中可能遇到的问题：

1.manjaro安装比较高级，他进入的是体验版，也就是manjaro try因为是读取启动盘的数据，可能比较慢，毕竟花里胡哨 ，类似PE那种吧

2.游戏本，也就是双显卡的电脑，需要屏蔽下独显才能进入上述图形化安装界面，方法都一样，修改引导配置，drive=后面的值修改为intel

安装后需要修改grub.cfg文件，修改每项启动引导配置，在boot参数后添加`nouveau.modeset=0`参数,解决lspci命令阻塞的问题,这是通法。

3.重启后进步了linux，即引导问题。进入bios查看boot引导方式，如果是legacy，建议换成UEFI，可能需要重新装机哦，现在的电脑一般都是默认支持UEFI的，它的引导管理还是很舒适的，对于装多系统的人比较友好，如果你执意使用传统的引导方式，建议重新安装manjaro，并在安装选项中，找到引导安装选项，安装到与你windows系统，即默认引导盘相同的硬盘上，重启后你就能顺利进入manjaro的grub引导界面了

4.Linux与Windows双系统时间错乱问题解决方法

Windows把系统硬件时间当作本地时间(local time)，即操作系统中显示的时间跟BIOS中显示的时间是一样的。

Linux/Unix/Mac把硬件时间当作UTC，操作系统中显示的时间是硬件时间经过换算得来的，比如说北京时间是GMT+8，则系统中显示时间是硬件时间+8。而Windows显示的是硬件时间，所以两个时间会发生错乱。

在 Windows 把硬件时间当作 UTC
开 始->运行->CMD，打开命令行程序(以管理员方式打开命令行程序方可有权限访问注册表)，在命令行中输入下面命令并回车

```
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
```

## 安装后的配置

1.安装后就可以先配置国内的软件源。使用以下命令，生成可用中国镜像站列表：

```
sudo pacman-mirrors -i -c China -m rank
```

勾选ping最低的就好了

2.在 `/etc/pacman.conf`文件末尾添加一下两行:

```
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

3.安装`archlinuxcn-keyring`:

```
sudo pacman -S archlinuxcn-keyring
sudo pacman -Syu
```

4.修改Home下的目录为英文

修改目录映射文件名；
```
vim ~/.config/user-dirs.dirs
```
修改为以下内容：

```
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Download"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_VIDEOS_DIR="$HOME/Videos"
```

将Home目录下的中文目录名改为对应的中文名；

```
	cd ~
	mv 公共 Public
	mv 模板 Templates
	mv 视频 Videos
	mv 图片 Pictures
	mv 文档 Documents
	mv 下载 Download
	mv 音乐 Music
	mv 桌面 Desktop
```

5.安装搜狗拼音

```
sudo pacman -S fcitx-im    #默认全部安装
sudo pacman -S fcitx-configtool
sudo pacman -S fcitx-sogoupinyin
```
新建`~/.xprofile`文件，加入如下内容
```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```
重启后生效

## 安装常用软件

先介绍几条pacman的常用命令

```
	pacman -S  #安装

	pacman -Syu #更新源并安装

	pacman -U #安装本地的包

	pacman -Sc #清理缓存

	pacman -R #卸载
```

> sudo pacman -S google-chrome
>
> sudo pacman -S firefox firefox-i18n-zh-cn
>
> sudo pacman -S pycharm
>
> sudo pacman -S yaourt
>
> sudo pacman -S git
>
> sudo pacman -S netease-cloud-music
>
> sudo pacman -S xflux-gui-git
>
> sudo pacman -S file-roller unrar unzip p7zip
>
> yaourt -S wps-office
>
> sudo pacman -S visual-studio-code-bin
>
> sudo pacman -S flameshot

另外要注意的是，如果你使用ssr，需要在网络连接设置全局代理，否则终端和浏览器无法走代理上网，又或者日常使用chrome的switchyOmega插件来实现pac代理。还有一点，因为我单纯只是用来学习二进制的，所以没有一直纠结于VMware工作站无法正常使用的问题，也尝试解决过，但是网络上的方法貌似都过时了，wiki也没有再更新，VM官方也表示不支持arch，so 如果你需要用到这个工作站，最好别入坑😉
