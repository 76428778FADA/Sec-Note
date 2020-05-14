其实还有很多其他开源的CTF平台，之所以选择CTFd主要考虑到简便，成本低，DIY几个特性，FBCTF也是个很棒的比赛平台，界面很炫酷，但是资源占用比较大，另外因为被强，部署难度较麻烦，亲测后决定放弃。miniCTF功能不能满足需求。至于想深入了解去CTFd官网巧巧吧！

<!-- more -->
## 概述

CTFd是一款基于Apache2.0的协议的开源CTF平台，最新版本目前为2.1.2。该平台功能强大，基本上能够满足目前的CTF竞赛需求，同时，该平台提供了强大的插件功能，可以自己进行插件开发实现自己的功能。

## 注意事项
> 本次平台的搭建示例是在本地虚拟机centos 7下完成的，请保证系统环境正常。**如果需要部署在云服务器上，请准备好ssh工具(推荐xshell)道理大体相同，只是最后为了让访问更流畅建议做下优化，文章末尾会做说明！**

## 前期准备

### 0.系统环境
虚拟机的话最好使用桥接，提前排除这个出错的可能性，云服务器可以忽略这一点
安利一波系统下载地址，推荐使用国内镜像站下载：

[清华大学开源软件镜像站][2]

为了示例我选择mini版本

### 1.检查网络环境

安装成功后建议测试下网络，`ip addr`没有正常获取地址的话，尝试重启网络服务`systemctl restart network`

日常redhat系用的少，命令变生疏了（狗头）

### 2.终端连接

其实，*CentOS* 7安装完成，*默认*是已经打开了22端口的。自带的*SSH*服务是*OpenSSH*中的一个独立守护进程*SSHD* 

所以可以直接连接，很方便，如果遇到错误可以查阅相关文档

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640390.png)

### 3.yum换源

```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup 
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum clean all   
yum makecache 
```
### 4.安装git

```
yum install git
```
### 5.安装pip
```
yum install python-pip
pip install --upgrade pip
```
pip换源

```
mkdir ~/.pip
echo -e "[global]\nindex-url = https://pypi.douban.com/simple/\n[install]\ntrusted-host = pypi.douban.com" >  ~/.pip/pip.conf
```

### 6.安装Docker

安装需要的软件包

```shell
yum install -y yum-utils device-mapper-persistent-data lvm2 bind-utils
```

设置yum源

```shell
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

安装docker

```shell
yum install docker-ce
```

启动并加入开机启动

```text
systemctl start docker
systemctl enable docker
```

验证是否安装成功

```text
docker version
```
![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640422.png)

### 7.安装docker-compose

```shell
yum -y install epel-release 
pip install docker-compose
```

检查docker-compose是否成功安装

```text
docker-compose -version
```

## 部署阶段

### 1.下载CTFd

```
git clone https://github.com/CTFd/CTFd.git
chmod -R 755 CTFd/
```

> vim使用科普-->命令模式下输入/后可以实现类似Ctrl+F的功能搜索文本内容，按n查找下一条，当然你也可以在本地git clone下载CTFd文件先修改后上传

浏览CTFd目录结构，主要关注的是`Themes`，之后可以DIY主题，如要上传在本地修改好的主题文件

xshell终端推荐使用`lrzsz`，`sz file`：下载；`rz`：上传

以及`docker-compose.yml`，可以对修改部署配置

### 2.安装CTFd

在CTF维基https://github.com/CTFd/CTFd/wiki/Getting-Started 中写了详细的安装步骤。

简易采用第二种方式（docker安装）

**常规方式**

```
cd CTFd/
# 安装操作系统需要安装的包
./prepare.sh
# 安装python需要的包
pip install -r requirements.txt
# 运行CTFd
python serve.py
```
> 接下去会下载很多东西，也就是跑下脚本一键部署平台所需要的环境，如果出现红字报错或者各种依赖问题，可以尝试update或者solo下，每个人情况不一，此类问题自行解决

完成以上步骤只是在本地搭起服务器，要是想在公网（物理机）访问，还需要安装gunicorn
```
        pip install gunicorn
        sudo (gunicorn --bind 0.0.0.0:8000 -w 4 "CTFd:create_app()"&)
        // 这里加了()还有&是为了那能够后台运行  [0.0.0.0]不用修改
        //gunicorn的命令一定要进CTFd目录输入
        //访问虚拟机（服务器）公网IP即可看见平台
```
如果你是在虚拟机部署，请切换为NAT连接，在VM虚拟网路编辑器上，将虚拟机的8000端口映射到本机上，即可实现物理机访问，桥接模式即可直接在局域网内共享平台

**docker安装**

```
cd CTFd/
docker-compose up -d
```
静静等待安装完成

✔推荐使用docker部署平台,无需苦恼环境问题,直接pull官方提供的依赖环境,搭建后的访问速度明显提升~<br>
**PS：在云服务器搭建，请先在安全组里开放8000端口**

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640509.jpg)

如果安装成功不能访问，看下是不是防火墙把端口给过滤掉了。

```
firewall-cmd --zone=public --add-port=8000/tcp --permanent
```

### 整站镜像下载（ubuntu）

>如果你最终无法成功部署，只是想在本地局域网内使用，可以尝试下载博主搭建好的虚拟机镜像玩一玩，***使用前注意重启虚拟机，因为快照是开机状态，NAT地址段可能不一样，需要重新获取***
>压缩包密码：`qymua.com`（平台未进行任何配置和优化）
>压缩包大小：**3.01G**
>解压后大小：**13G**
>压缩包MD5：`ef601c06af91f4c7532cbeaac7b324f0`

<a id="download" href="https://pan.baidu.com/s/1IEQ5xo7BhZmG5jvx993fnA"><i class="fa fa-download"></i><span> Download Now</span> </a>

`密码:da8m`

**注** ：文章已更新，这是很早以前的，我也懒得删了XD

## 运维与优化

CTFd的数据库用的是mariadb，看一下docker运行了哪些容器

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640473.png)

可以看到运行了三个容器，分别是ctfd，mariadb，redis。

我们可以直接进入到各个容器进行操作。

docker exec -it [CONTAINER ID] /bin/bash

数据库root账户的密码默认为ctfd

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640524.png)

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640474.png)

### 配置Nginx

如果有需要的话也可以配置一下nginx，这样访问速度会变快，而且作为一个中间件更改端口会更方便(当然小伙伴们选择Apache也是可以的)。 参考链接

**确保所需环境已安装**

``` sql
yum install gcc-c++
yum install -y pcre pcre-devel
yum install -y zlib zlib-devel
yum install -y openssl openssl-devel
```

根目录下新建一个文件夹nginx

``` jboss-cli
mkdir /nginx
cd /nginx
wget https://nginx.org/download/nginx-1.14.2.tar.gz
tar -zxvf nginx-1.14.2.tar.gz
```

然后进入到目录下进行编译

``` vim
./configure
make
make install
```
查找一下nginx的位置 whereis nginx

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589471640286.png)

nginx常见命令

启动、停止nginx

``` jboss-cli
cd /usr/local/nginx/sbin/
./nginx
./nginx -s stop
./nginx -s quit
./nginx -s reload
./nginx -s quit:此方式停止步骤是待nginx进程处理任务完毕进行停止。
./nginx -s stop:此方式相当于先查出nginx进程id再使用kill命令强制杀掉进程。
```

nginx开机自启动
即在`rc.local`增加启动代码就可以了。 `vi /etc/rc.local`

增加一行 `/usr/local/nginx/sbin/nginx` (根据whereis nginx实际的位置为准)

设置执行权限：`chmod 755 rc.local`

配置nginx 配置之前需要先运行一下nginx

``` jboss-cli
./nginx
./nginx -s quit
```

然后在修改配置文件

vim /usr/local/nginx/conf/nginx.conf（whereis nginx 实际情况）

server下的location替换为

`server_name` 可以换成你想绑定的域名，别忘了DNS添加记录

``` nginx
location /{
proxy_pass http://localhost:8000;
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_redirect off;
}
```
最后别忘了，云服务器上部署需要在安全组手动开启对外开放的端口

> 为了方便监控服务器，推荐装个BT面板

```
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
```

[1]: https://ctfd.io/
[2]: https://mirrors.tuna.tsinghua.edu.cn/#
