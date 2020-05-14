# 前记

---

最近使用`docker`比较多，但是偶然间使用VM的时候遇到了兼容性冲突问题

使用过`VMware WorkStation`的朋友应该知道，`vm`无法与`hyper-v`共存。那么如果我的电脑已经安装和使用VM，如何才能使用`Docker for Windows`呢，如果要同时使用就只能放弃hyper-v啦

`Docker for Windows` 不同于 `Docker Toolbox`。Docker for Windows 对系统的要求至少为`Windows 10`专业版，因为它需要`Hyper-V`的支持，而Dockbox Toolbox使用`Oracle Virtual Box`而不是Hyper-V . 

但是我不希望`docker-machine`使用`Virtual Box`，相关配置我是参考`Toolbox`，道理是一样的XD

# 安装Docker for Windows

## 下载Docker for Windows

从这个地址下载并进行安装：[docker for windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

安装过程中如果遇到系统版本不适配的问题可以修改`EditionID`的变量值为`Profession` ，注册表地址如下：

``` tex
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion
```

> 安装成功后不要启动服务

## 关闭Hyper-v

``` gams
bcdedit /set hypervisorlaunchtype off
```
管理员身份运行成功后重启计算机

## 准备工作

**1、下载最新版本boot2docker.iso**

下载地址 https://github.com/boot2docker/boot2docker/releases

然后将 boot2docker.iso 放在 `C:\Users\<用户名>\.docker\machine\cache\`，文件夹不存在就自己建立

**2、下载 VMware Workstation 驱动**

从这里下载 https://github.com/pecigonzalo/docker-machine-vmwareworkstation/releases/ 

最新版的vm驱动。此驱动非官方开发，但是也在官方的文档中有链接

然后将 `docker-machine-driver-vmwareworkstation.exe`复制到 `C:\Program Files\Docker\Docker\resources\bin` 下：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473062700.png)

## 安装Docker Machine

Docker Machine 是 Docker 官方提供的一个工具，它可以帮助我们在远程的机器上安装 Docker，或者在虚拟机 host 上直接安装虚拟机并在虚拟机中安装 Docker。我们还可以通过 docker-machine 命令来管理这些虚拟机和 Docker。下面是来自 Docker Machine 官方文档的一张图，很形象哦！

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473063925.png)

Docker Machine 的安装十分简单，如果在远程主机中直接把可执行文件下载到本地就可以了。

``` ruby
$ curl -L https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-`uname -s`-`uname -m` > /tmp/docker-machine
$ chmod +x /tmp/docker-machine
$ sudo mv /tmp/docker-machine /usr/local/bin/docker-machine
```
其中 v0.12.0 是最新的版本。当然 Docker Machine 是个开源项目，你可以选择安装不同的版本，或者是自行编译。因为我不太需要在远程搭建docker，所以就不过多介绍了XD，下面还是继续正题

**1、打开VMware Workstation**

这一步是必须的！VM版本必须大于10

**2、安装Docker-dev**

打开cmd，执行命令

``` livecodeserver
docker-machine create --driver=vmwareworkstation Docker-dev 
//docker-dev实际上是虚拟机的名称，可自定义
```

执行过程如下(由于第一次安装成功没有截图，找到一张一样的来凑凑XD)

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473062862.png)

**3、验证安装**

``` stata
docker-machine ls
```

会出现看到刚刚安装的`docker-dev`实例

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473063636.png)

如果列表有之前安装失败或者旧的dev，可以使用命令清除

``` xml
docker-machine rm -f  <NAME>
```
**4、激活实例**

执行命令：

``` ebnf
docker-machine env Docker-dev
```
会出现要你配置的环境变量：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473062761.png)

依次添加环境变量即可

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473063116.png)

**5、验证是否安装成功**

**登录dev实例**

使用命令登录：

``` ebnf
docker-machine ssh Docker-dev
```

出现如下表示成功：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473063284.png)

## 收尾工作

**1、配置加速器**

通过命令登录docker-machine

按照加速服务提供商的教程执行命令即可

本质上就是 

新建文件 `vi /etc/docker/daemon.json`

输入以下内容

```
{
  "registry-mirrors": ["你的加速器地址"]
}
```

保存重启虚拟机即可

为了方便管理，你还可以在VMware 中添加你刚刚创建的`Docker-dev`

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473063705.png)

**2.ssh连接方式**

通常情况下，推荐使用 `docker-machine ssh default` 进行登录，不需要输入密码。`default` 是默认的 `machine` 名字。

在 `boot2docker` 中，默认的用户名和密码是：

``` avrasm
user: docker
pass: tcuser
```

登录方法：

``` julia
$ ssh docker@localhost -p 2022
docker@localhost's password: tcuser
                        ##        .
                  ## ## ##       ==
               ## ## ## ##      ===
           /""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
           \______ o          __/
             \    \        __/
              \____\______/
```
这样我就能很方便的管理docker

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473063135.png)

**3.移动Docker-machine**

因为安装的时候必须在`docker`目录下安装，而`docker for windows`默认在`C`盘，现在已经装好了，所以我们可以悄悄把`machines/`目录下的Docker-dev虚拟机放到其他盘，避免占用太大空间，因为images是存储在虚拟机里的

修改环境变量`DOCKER_CERT_PATH` ，地址换成你转移的目录，重启电脑

**4、关闭Docker Desktop 服务**

由于没有使用`hyper-v` 所以本地没必要起这个服务，可以把开机自启项去掉

每次使用的时候开启虚拟机Docker-dev即可

用法都一样，在vscode中依然正常连接，只是在终端使用的时候要ssh连接Docker-dev而已

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473062802.png)

> 果然还是入手mac是最高效的XD 花钱省心 ！


