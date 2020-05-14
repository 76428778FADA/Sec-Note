# 前言

进入这个圈子挺久了，还没碰过docker，趁着暑假闲得慌，打一波基础XD 

😄docker是个好东西，在CTF比赛中我们可以经常遇到通过docker部署的web，或者Pwn环境，同样我们也可以将一些服务部署在docker里面，管理方便，并且较为安全。

贴几个学习网址：[Docker Hub](https://registry.hub.docker.com/search?q=library) 、[docker中文社区](http://www.docker.org.cn/index.html)、[docker dcos](https://docs.docker.com)、[docker从入门到实践(超全)](https://yeasy.gitbooks.io/docker_practice/)

接下来分三个部分入门docker：docker概念、docker使用、docker-CTF运用

# Docker概念

---

> **Docker 是世界领先的软件容器平台**，所以想要搞懂Docker的概念我们必须先从容器开始说起。

## 先从认识容器开始

### 什么是容器?

#### 先来看看容器较为官方的解释

**一句话概括容器：容器就是将软件打包成标准化单元，以用于开发、交付和部署。** 

- **容器镜像是轻量的、可执行的独立软件包** ，包含软件运行所需的所有内容：代码、运行时环境、系统工具、系统库和设置。
- **容器化软件适用于基于Linux和Windows的应用，在任何环境中都能够始终如一地运行。**
- **容器赋予了软件独立性**　，使其免受外在环境差异（例如，开发和预演环境的差异）的影响，从而有助于减少团队间在相同基础设施上运行不同软件时的冲突。

#### 再来看看容器较为通俗的解释

**如果需要通俗的描述容器的话，我觉得容器就是一个存放东西的地方，就像书包可以装各种文具、衣柜可以放各种衣服、鞋架可以放各种鞋子一样。我们现在所说的容器存放的东西可能更偏向于应用比如网站、程序甚至是系统环境。**

![认识容器](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846201.png)

### 图解物理机,虚拟机与容器
关于虚拟机与容器的对比在后面会详细介绍到，这里只是通过网上的图片加深大家对于物理机、虚拟机与容器这三者的理解。

**物理机**
![物理机](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846163.jpg)

**虚拟机：**

![虚拟机](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846178.jpg)

**容器：**

![容器](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846232.jpg)

通过上面这三张抽象图，我们可以大概可以通过类比概括出： **容器虚拟化的是操作系统而不是硬件，容器之间是共享同一套操作系统资源的。虚拟机技术是虚拟出一套硬件后，在其上运行一个完整操作系统。因此容器的隔离级别会稍低一些。**

---

> 相信通过上面的解释大家对于容器这个既陌生又熟悉的概念有了一个初步的认识，下面我们就来谈谈Docker的一些概念。

## 再来谈谈 Docker 的一些概念

![Docker的一些概念](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846325.png)

### 什么是 Docker?

说实话关于Docker是什么并太好说，下面我通过四点向你说明Docker到底是个什么东西。

- **Docker 是世界领先的软件容器平台。** 
- **Docker** 使用 Google 公司推出的 **Go 语言**  进行开发实现，基于 **Linux 内核** 的cgroup，namespace，以及AUFS类的**UnionFS**等技术，**对进程进行封装隔离，属于操作系统层面的虚拟化技术。** 由于隔离的进程独立于宿主和其它的隔离的进
程，因此也称其为容器。**Docke最初实现是基于 LXC.**
- **Docker 能够自动执行重复性任务，例如搭建和配置开发环境，从而解放了开发人员以便他们专注在真正重要的事情上：构建杰出的软件。**
- **用户可以方便地创建和使用容器，把自己的应用放入容器。容器还可以进行版本管理、复制、分享、修改，就像管理普通的代码一样。**

![什么是Docker](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846575.jpg)

### Docker 思想

- **集装箱**
- **标准化：** ①运输方式    ② 存储方式 ③ API接口
- **隔离**

### Docker 容器的特点

- #### 轻量

  在一台机器上运行的多个 Docker 容器可以共享这台机器的操作系统内核；它们能够迅速启动，只需占用很少的计算和内存资源。镜像是通过文件系统层进行构造的，并共享一些公共文件。这样就能尽量降低磁盘用量，并能更快地下载镜像。
- #### 标准

  Docker 容器基于开放式标准，能够在所有主流 Linux 版本、Microsoft Windows 以及包括 VM、裸机服务器和云在内的任何基础设施上运行。
- #### 安全

  Docker 赋予应用的隔离性不仅限于彼此隔离，还独立于底层的基础设施。Docker 默认提供最强的隔离，因此应用出现问题，也只是单个容器的问题，而不会波及到整台机器。

### 为什么要用 Docker ?

- **Docker 的镜像提供了除内核外完整的运行时环境，确保了应用运行环境一致性，从而不会再出现 “这段代码在我机器上没问题啊” 这类问题；——一致的运行环境**
- **可以做到秒级、甚至毫秒级的启动时间。大大的节约了开发、测试、部署的时间。——更快速的启动时间**
- **避免公用的服务器，资源会容易受到其他用户的影响。——隔离性**
- **善于处理集中爆发的服务器使用压力；——弹性伸缩，快速扩展**
- **可以很轻易的将在一个平台上运行的应用，迁移到另一个平台上，而不用担心运行环境的变化导致应用无法正常运行的情况。——迁移方便**
- **使用 Docker 可以通过定制应用镜像来实现持续集成、持续交付、部署。——持续交付和部署**

---

> 每当说起容器，我们不得不将其与虚拟机做一个比较。就我而言，对于两者无所谓谁会取代谁，而是两者可以和谐共存。

## 容器 VS 虚拟机

　　简单来说： **容器和虚拟机具有相似的资源隔离和分配优势，但功能有所不同，因为容器虚拟化的是操作系统，而不是硬件，因此容器更容易移植，效率也更高。**

### 两者对比图

　　传统虚拟机技术是虚拟出一套硬件后，在其上运行一个完整操作系统，在该系统上再运行所需应用进程；而容器内的应用进程直接运行于宿主的内核，容器内没有自己的内核，而且也没有进行硬件虚拟。因此容器要比传统虚拟机更为轻便.

![容器 VS 虚拟机](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846599.jpg)

### 容器与虚拟机总结

![容器与虚拟机 (VM) 总结](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846152.jpg)

- **容器是一个应用层抽象，用于将代码和依赖资源打包在一起。** **多个容器可以在同一台机器上运行，共享操作系统内核，但各自作为独立的进程在用户空间中运行** 。与虚拟机相比， **容器占用的空间较少**（容器镜像大小通常只有几十兆），**瞬间就能完成启动** 。

- **虚拟机 (VM) 是一个物理硬件层抽象，用于将一台服务器变成多台服务器。** 管理程序允许多个 VM 在一台机器上运行。每个VM都包含一整套操作系统、一个或多个应用、必要的二进制文件和库资源，因此 **占用大量空间** 。而且 VM  **启动也十分缓慢** 。

　　通过Docker官网，我们知道了这么多Docker的优势，但是大家也没有必要完全否定虚拟机技术，因为两者有不同的使用场景。**虚拟机更擅长于彻底隔离整个运行环境**。例如，云服务提供商通常采用虚拟机技术隔离不同的用户。而 **Docker通常用于隔离不同的应用** ，例如前端，后端以及数据库。

  ![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846838.png)

如上图所示，Docker 守护进程运行在一台主机上。用户并不直接和守护进程进行交互，而是通过 Docker 客户端间接和其通信。
Docker 客户端，实际上是 docker 的二进制程序，是主要的用户与 Docker 交互方式。它接收用户指令并且与背后的 Docker 守护进程通信，如此来回往复。


### 容器与虚拟机两者是可以共存的

就我而言，对于两者无所谓谁会取代谁，而是两者可以和谐共存。

![两者是可以共存的](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846893.jpg)

---

>  Docker中非常重要的三个基本概念，理解了这三个概念，就理解了 Docker 的整个生命周期。

## Docker基本概念

Docker 包括三个基本概念

- **镜像（Image）**
- **容器（Container）**
- **仓库（Repository）**

理解了这三个概念，就理解了 Docker 的整个生命周期

![Docker 包括三个基本概念](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472847042.jpg)

### 镜像(Image):一个特殊的文件系统

　　**操作系统分为内核和用户空间**。对于 Linux 而言，内核启动后，会挂载 root 文件系统为其提供用户空间支持。而Docker 镜像（Image），就相当于是一个 root 文件系统。

　　**Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。** 镜像不包含任何动态数据，其内容在构建之后也不会被改变。

　　镜像（`Image`）就是一堆只读层（`read-only layer`）的统一视角，也许这个定义有些难以理解，下面的这张图能够帮助读者理解镜像的定义。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472847166.png)

　　从左边我们看到了多个只读层，它们重叠在一起。除了最下面一层，其它层都会有一个指针指向下一层。这些层是Docker 内部的实现细节，并且能够在主机的文件系统上访问到。统一文件系统 (union file system) 技术能够将不同的层整合成一个文件系统，为这些层提供了一个统一的视角，这样就隐藏了多层的存在，在用户的角度看来，只存在一个文件系统。我们可以在图片的右边看到这个视角的形式。

　　Docker 设计时，就充分利用 **Union FS**的技术，将其设计为 **分层存储的架构** 。 镜像实际是由多层文件系统联合组成。

　　**镜像构建时，会一层层构建，前一层是后一层的基础。每一层构建完就不会再发生改变，后一层上的任何改变只发生在自己这一层。**　比如，删除前一层文件的操作，实际不是真的删除前一层的文件，而是仅在当前层标记为该文件已删除。在最终容器运行的时候，虽然不会看到这个文件，但是实际上该文件会一直跟随镜像。因此，在构建镜像的时候，需要额外小心，每一层尽量只包含该层需要添加的东西，任何额外的东西应该在该层构建结束前清理掉。

　　分层存储的特征还使得镜像的复用、定制变的更为容易。甚至可以用之前构建好的镜像作为基础层，然后进一步添加新的层，以定制自己所需的内容，构建新的镜像。

### 容器(Container):镜像运行时的实体

　　镜像（Image）和容器（Container）的关系，就像是面向对象程序设计中的 类 和 实例 一样，镜像是静态的定义，**容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等** 。

　　**容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 命名空间。前面讲过镜像使用的是分层存储，容器也是如此。**

　　**容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。**

　　按照 Docker 最佳实践的要求，**容器不应该向其存储层内写入任何数据** ，容器存储层要保持无状态化。**所有的文件写入操作，都应该使用数据卷（Volume）、或者绑定宿主目录**，在这些位置的读写会跳过容器存储层，直接对宿主(或网络存储)发生读写，其性能和稳定性更高。数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡。因此， **使用数据卷后，容器可以随意删除、重新 run ，数据却不会丢失。**


### 仓库(Repository):集中存放镜像文件的地方

　　镜像构建完成后，可以很容易的在当前宿主上运行，但是， **如果需要在其它服务器上使用这个镜像，我们就需要一个集中的存储、分发镜像的服务，Docker Registry就是这样的服务。**

　　一个 Docker Registry中可以包含多个仓库（Repository）；每个仓库可以包含多个标签（Tag）；每个标签对应一个镜像。所以说：**镜像仓库是Docker用来集中存放镜像文件的地方类似于我们之前常用的代码仓库。**

　　通常，**一个仓库会包含同一个软件不同版本的镜像**，而**标签就常用于对应该软件的各个版本** 。我们可以通过`<仓库名>:<标签>`的格式来指定具体是这个软件哪个版本的镜像。如果不给出标签，将以 latest 作为默认标签.。

**这里补充一下Docker Registry 公开服务和私有 Docker Registry的概念：**

　　**Docker Registry 公开服务** 是开放给用户使用、允许用户管理镜像的 Registry 服务。一般这类公开服务允许用户免费上传、下载公开的镜像，并可能提供收费服务供用户管理私有镜像。

　　最常使用的 Registry 公开服务是官方的 **Docker Hub** ，这也是默认的 Registry，并拥有大量的高质量的官方镜像，网址为：[https://hub.docker.com/](https://hub.docker.com/) 。在国内访问**Docker Hub** 可能会比较慢国内也有一些云服务商提供类似于 Docker Hub 的公开服务。比如 [时速云镜像库](https://hub.tenxcloud.com/)、[网易云镜像服务](https://www.163yun.com/product/repo)、[DaoCloud 镜像市场](https://www.daocloud.io/)、[阿里云镜像库](https://www.aliyun.com/product/containerservice?utm_content=se_1292836)等。
**例如：**
配置阿里云镜像加速器

针对Docker客户端版本大于 1.10.0 的用户

您可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器

也就是执行下面的shell脚本即可

```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://xxxxxxx.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```
　　除了使用公开服务外，用户还可以在 **本地搭建私有 Docker Registry** 。Docker 官方提供了 Docker Registry 镜像，可以直接使用做为私有 Registry 服务。开源的 Docker Registry 镜像只提供了 Docker Registry API 的服务端实现，足以支持 docker 命令，不影响使用。但不包含图形界面，以及镜像维护、用户管理、访问控制等高级功能。


### 命名空间(Namespaces)

**pid namespace**

不同用户的进程就是通过 pid namespace 隔离开的，且不同 namespace 中可以有相同 PID。具有以下特征:

- 每个 namespace 中的 pid 是有自己的 pid=1 的进程(类似 /sbin/init 进程)
- 每个 namespace 中的进程只能影响自己的同一个 namespace 或子 namespace 中的进程
- 因为 /proc 包含正在运行的进程，因此在 container 中的 pseudo-filesystem 的 /proc 目录只能看到自己 namespace 中的进程
- 因为 namespace 允许嵌套，父 namespace 可以影响子 namespace 的进程，所以子 namespace 的进程可以在父 namespace 中看到，但是具有不同的 pid
参考文档：[Introduction to Linux namespaces – Part 3: PID](https://blog.jtlebi.fr/2014/01/05/introduction-to-linux-namespaces-part-3-pid/)

**mnt namespace**

类似 chroot，将一个进程放到一个特定的目录执行。mnt namespace 允许不同 namespace 的进程看到的文件结构不同，这样每个 namespace 中的进程所看到的文件目录就被隔离开了。同 chroot 不同，每个 namespace 中的 container 在 /proc/mounts 的信息只包含所在 namespace 的 mount point。

**net namespace**

网络隔离是通过 net namespace 实现的， 每个 net namespace 有独立的 network devices, IP addresses, IP routing tables, /proc/net 目录。这样每个 container 的网络就能隔离开来。 docker 默认采用 veth 的方式将 container 中的虚拟网卡同 host 上的一个 docker bridge 连接在一起。

参考文档：[Introduction to Linux namespaces – Part 5: NET](https://blog.jtlebi.fr/2014/01/19/introduction-to-linux-namespaces-part-5-net/)

**uts namespace**

UTS ("UNIX Time-sharing System") namespace 允许每个 container 拥有独立的 hostname 和 domain name, 使其在网络上可以被视作一个独立的节点而非 Host 上的一个进程。

参考文档：[Introduction to Linux namespaces – Part 1: UTS](https://blog.jtlebi.fr/2013/12/22/introduction-to-linux-namespaces-part-1-uts/)

**ipc namespace**

container 中进程交互还是采用 Linux 常见的进程间交互方法 (interprocess communication - IPC), 包括常见的信号量、消息队列和共享内存。然而同 VM 不同，container 的进程间交互实际上还是 host 上具有相同 pid namespace 中的进程间交互，因此需要在IPC资源申请时加入 namespace 信息 - 每个 IPC 资源有一个唯一的 32bit ID。

参考文档：[Introduction to Linux namespaces – Part 2: IPC](https://blog.jtlebi.fr/2013/12/28/introduction-to-linux-namespaces-part-2-ipc/)

**user namespace**

每个 container 可以有不同的 user 和 group id, 也就是说可以以 container 内部的用户在 container 内部执行程序而非 Host 上的用户。

有了以上 6 种 namespace 从进程、网络、IPC、文件系统、UTS 和用户角度的隔离，一个 container 就可以对外展现出一个独立计算机的能力，并且不同 container 从 OS 层面实现了隔离。 然而不同 namespace 之间资源还是相互竞争的，仍然需要类似 ulimit 来管理每个 container 所能使用的资源 - cgroup。

**Reference**
- [Docker Getting Start: Related Knowledge](http://tiewei.github.io/cloud/Docker-Getting-Start/)
- [Docker 介绍以及其相关术语、底层原理和技术](https://ruby-china.org/topics/22004)

### 资源配额(cgroups)

**cgroups** 实现了对资源的配额和度量。 cgroups 的使用非常简单，提供类似文件的接口，在 /cgroup 目录下新建一个文件夹即可新建一个 group，在此文件夹中新建 task 文件，并将 pid 写入该文件，即可实现对该进程的资源控制。具体的资源配置选项可以在该文件夹中新建子 subsystem ，{子系统前缀}.{资源项} 是典型的配置方法， 如 memory.usageinbytes 就定义了该 group 在 subsystem memory 中的一个内存限制选项。 另外，cgroups 中的 subsystem 可以随意组合，一个 subsystem 可以在不同的 group 中，也可以一个 group 包含多个 subsystem - 也就是说一个 subsystem。

- memory
	- 内存相关的限制
- cpu
	- 在 cgroup 中，并不能像硬件虚拟化方案一样能够定义 CPU 能力，但是能够定义 CPU 轮转的优先级，因此具有较高 CPU 优先级的进程会更可能得到 CPU 运算。 通过将参数写入 cpu.shares ,即可定义改 cgroup 的 CPU 优先级 - 这里是一个相对权重，而非绝对值
- blkio
	- block IO 相关的统计和限制，byte/operation 统计和限制 (IOPS 等)，读写速度限制等，但是这里主要统计的都是同步 IO
- devices
	- 设备权限限制
	

参考文档：[how to use cgroup](http://tiewei.github.io/devops/howto-use-cgroup/)

## Docker架构

  ![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472847712.png)

　 这张图展示了 Docker 客户端、服务端和 Docker 仓库（即 Docker Hub 和 Docker Cloud ），默认情况下Docker 会在 Docker 中央仓库寻找镜像文件，这种利用仓库管理镜像的设计理念类似于 Git ，当然这个仓库是可以通过修改配置来指定的，甚至我们可以创建我们自己的私有仓库。

  `Docker` 的核心组件包括：

 1. Docker Client
 2. Docker daemon
 3. Docker Image
 4. Docker Registry
 5. Docker Container

Docker 采用的是 Client/Server 架构。客户端向服务器发送请求，服务器负责构建、运行和分发容器。客户端和服务器可以运行在同一个 Host 上，客户端也可以通过 socket 或 REST API 与远程的服务器通信。

### Docker Client

Docker Client ，也称 Docker 客户端。它其实就是 Docker 提供命令行界面 (CLI) 工具，是许多 Docker 用户与 Docker 进行交互的主要方式。客户端可以构建，运行和停止应用程序，还可以远程与Docker_Host进行交互。最常用的 Docker 客户端就是 docker 命令，我们可以通过 docker 命令很方便地在 host 上构建和运行 docker 容器。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846674.png)

### Docker daemon

Docker daemon 是服务器组件，以 Linux 后台服务的方式运行，是 Docker 最核心的后台进程，我们也把它称为守护进程。它负责响应来自 Docker Client 的请求，然后将这些请求翻译成系统调用完成容器管理操作。该进程会在后台启动一个 API Server ，负责接收由 Docker Client 发送的请求，接收到的请求将通过Docker daemon 内部的一个路由分发调度，由具体的函数来执行请求。

我们大致可以将其分为以下三部分：

- Docker Server
- Engine
- Job
Docker Daemon的架构如下所示：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846659.png)

Docker Daemon 可以认为是通过 Docker Server 模块接受 Docker Client 的请求，并在 Engine 中处理请求，然后根据请求类型，创建出指定的 Job 并运行。 

Docker Daemon 运行在 Docker host 上，负责创建、运行、监控容器，构建、存储镜像。

运行过程的作用有以下几种可能：

- 向 Docker Registry 获取镜像
- 通过 graphdriver 执行容器镜像的本地化操作
- 通过 networkdriver 执行容器网络环境的配置
- 通过 execdriver 执行容器内部运行的执行工作

由于 Docker Daemon 和 Docker Client 的启动都是通过可执行文件 docker 来完成的，因此两者的启动流程非常相似。 Docker 可执行文件运行时，运行代码通过不同的命令行 flag 参数，区分两者，并最终运行两者各自相应的部分。

启动 Docker Daemon 时，一般可以使用以下命令来完成

``` 
docker --daemon = true
docker –d
docker –d = true
```
再由 docker 的 main() 函数来解析以上命令的相应 flag 参数，并最终完成 Docker Daemon 的启动。

下图可以很直观地看到 Docker Daemon 的启动流程：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472847177.png)

默认配置下， Docker daemon 只能响应来自本地 Host 的客户端请求。如果要允许远程客户端请求，需要在配置文件中打开 TCP 监听。我们可以照着如下步骤进行配置：

1、编辑配置文件 /etc/systemd/system/multi-user.target.wants/docker.service ，在环境变量 ExecStart 后面添加 -H tcp://0.0.0.0，允许来自任意 IP 的客户端连接。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846523.png)

2、重启 Docker daemon

``` 
systemctl daemon-reload
systemctl restart docker.service
```
3、我们通过以下命令即可实现与远程服务器通信

``` 
docker -H 服务器IP地址 info
```
**-H** 是用来指定服务器主机， **info** 子命令用于查看 Docker 服务器的信息

### Docker Image

Docker 镜像可以看作是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像不包含任何动态数据，其内容在构建之后也不会被改变。我们可将 Docker 镜像看成只读模板，通过它可以创建 Docker 容器。

镜像有多种生成方法：

1. 从无到有开始创建镜像
2. 下载并使用别人创建好的现成的镜像
3. 在现有镜像上创建新的镜像

我们可以将镜像的内容和创建步骤描述在一个文本文件中，这个文件被称作 `Dockerfile` ，通过执行 `docker build <docker-file>` 命令可以构建出 Docker 镜像,后面会详细介绍这个问题

### Docker Registry&Container

前面在讲基本概念的时候实际上已经很清楚了，这里不过多解释

Docker registry 是存储 docker image 的仓库，它在 docker 生态环境中的位置如下图所示：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846910.png)

运行docker push、docker pull、docker search时，实际上是通过 docker daemon 与 docker registry 通信。

Docker 容器就是 Docker 镜像的运行实例，是真正运行项目程序、消耗系统资源、提供服务的地方。 Docker Container 提供了系统硬件环境，我们可以使用 Docker Images 这些制作好的系统盘，再加上我们所编写好的项目代码， run 一下就可以提供服务啦。

---

> Docker的概念基本上已经讲完，最后我们谈谈：Build, Ship, and Run。

## 最后谈谈:Build Ship and Run
如果你搜索Docker官网，会发现如下的字样：**“Docker - Build, Ship, and Run Any App, Anywhere”**。那么Build, Ship, and Run到底是在干什么呢？

![build ship run](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472846876.jpg)

- **Build（构建镜像）** ： 镜像就像是集装箱包括文件以及运行环境等等资源。
- **Ship（运输镜像）** ：主机和仓库间运输，这里的仓库就像是超级码头一样。
- **Run （运行镜像）** ：运行的镜像就是一个容器，容器就是运行程序的地方。

**Docker 运行过程也就是去仓库把镜像拉到本地，然后用一条命令把镜像运行起来变成容器。所以，我们也常常将Docker称为码头工人或码头装卸工，这和Docker的中文翻译搬运工人如出一辙。**

**那么Docker组件是如何协作运行容器的呢？**

容器启动过程如下：

- Docker 客户端执行 docker run 命令
- Docker daemon 发现本地没有 hello-world 镜像
- daemon 从 Docker Hub 下载镜像
- 下载完成，镜像 hello-world 被保存到本地
- Docker daemon 启动容器


# Docker使用

---

## Docker的安装

Docker 的安装和使用有一些前提条件，主要体现在体系架构和内核的支持上。对于体系架构，除了 Docker 一开始就支持的 X86-64 ，其他体系架构的支持则一直在不断地完善和推进中。

Docker 分为 **CE** 和 **EE** 两大版本。 CE 即社区版（免费，支持周期 7 个月）， EE 即企业版，强调安全，付费使用，支持周期 24 个月。

我们在安装前可以参看官方文档获取最新的 Docker 支持情况，官方文档在这里：

``` 
https://docs.docker.com/install/
```
Docker 对于内核支持的功能，即内核的配置选项也有一定的要求(比如必须开启 **Cgroup** 和 **Namespace** 相关选项，以及其他的网络和存储驱动等)， Docker 源码中提供了一个检测脚本来检测和指导内核的配置，脚本链接在这里：

``` 
https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh
```
在满足前提条件后，安装就变得非常的简单了。

Docker CE 的安装请参考官方文档：

- MacOS：https://docs.docker.com/docker-for-mac/install/
- Windows：https://docs.docker.com/docker-for-windows/install/
- Ubuntu：https://docs.docker.com/install/linux/docker-ce/ubuntu/
- Debian：https://docs.docker.com/install/linux/docker-ce/debian/
- CentOS：https://docs.docker.com/install/linux/docker-ce/centos/
- Fedora：https://docs.docker.com/install/linux/docker-ce/fedora/
- 其他 Linux 发行版：https://docs.docker.com/install/linux/docker-ce/binaries/

运行 docker version or docker info 验证是否安装成功

``` yaml
λ docker version
Client: Docker Engine - Community
 Version:           19.03.1
 API version:       1.40
 Go version:        go1.12.5
 Git commit:        74b1e89
 Built:             Thu Jul 25 21:17:08 2019
 OS/Arch:           windows/amd64
 Experimental:      false
```
在linux下还需手动确保可以正常启动

``` 
$ sudo systemctl enable docker
$ sudo systemctl start docker
```

> 目前docker在windows家庭版中安装还比较坑，你需要手动安装Hyper-V服务(.cmd文件内容如下)，并绕过docker安装程序的系统版本检测，另外，安装时不要勾选：use windows containers instead of linux containers

```
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hyper-v.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL

```
![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472847222.png)


## Docker-image

>镜像作为 Docker 三大核心概念中，最重要的一个关键词，它有很多操作，是您想学习容器技术不得不掌握的。

### Docker 下载镜像

如果我们想要在本地运行容器，就必须保证本地存在对应的镜像。所以，第一步，我们需要下载镜像。当我们尝试下载镜像时，Docker 会尝试先从默认的镜像仓库（默认使用 Docker Hub 公共仓库）去下载，当然了，用户也可以自定义配置想要下载的镜像仓库。

**下载镜像**

镜像是运行容器的前提，我们可以使用 `docker pull[IMAGE_NAME]:[TAG]`命令来下载镜像，其中 `IMAGE_NAME` 表示的是镜像的名称，而 `TAG` 是镜像的标签，也就是说我们需要通过 “**镜像 + 标签**” 的方式来下载镜像。

具体的选项可以通过 docker pull --help 命令看到，这里我们说一下镜像名称的格式。

- Docker 镜像仓库地址：地址的格式一般是 <域名/IP>[:端口号]。默认地址是 Docker Hub。
- 仓库名：如之前所说，这里的仓库名是两段式名称，即 <用户名>/<软件名>。对于 Docker Hub，如果不给出用户名，则默认为 library，也就是官方镜像。

**注意：** 您也可以不显式地指定 TAG, 它会默认下载 latest 标签，也就是下载仓库中最新版本的镜像。这里并不推荐您下载 latest 标签，因为该镜像的内容会跟踪镜像的最新版本，并随之变化，所以它是不稳定的。在生产环境中，可能会出现莫名其妙的 bug, 推荐您最好还是显示的指定具体的 TAG。

举个例子，如我们想要下载一个 Mysql 5.7 镜像，可以通过命令来下载：

```
docker pull mysql:5.7
```

会看到控制台输出内容如下：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848374.png)

**注意：** 由于官方 DockerHub 仓库服务器在国外，下载速度较慢，所以我将仓库的地址更改成了国内的 `docker.io` 的镜像仓库，所以在上图中，镜像前面会有 `docker.io` 出现。

当有 **Downloaded** 字符串输出的时候，说明下载成功了！！

 **验证**

让我们来验证一下，本地是否存在 Mysql5.7 的镜像，运行命令：

```
docker images
```

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848931.png)

可以看到本地的确存在该镜像，确实是下载成功了！

**下载镜像相关细节**

再说说上面下载镜像的过程：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848322.png)

通过下载过程，可以看到，一个镜像一般是由多个层（ `layer`） 组成，类似 `9fc222b64b0a`这样的串表示层的唯一 ID（实际上完整的 ID 包括了 256 个 bit, 64 个十六进制字符组成）。

**您可能会想，如果多个不同的镜像中，同时包含了同一个层（ layer）,这样重复下载，岂不是导致了存储空间的浪费么?**

实际上，Docker 并不会这么傻会去下载重复的层（ `layer`）,Docker 在下载之前，会去检测本地是否会有同样 ID 的层，如果本地已经存在了，就直接使用本地的就好了。

**另一个问题，不同仓库中，可能也会存在镜像重名的情况发生, 这种情况咋办？**

严格意义上，我们在使用 `docker pull` 命令时，还需要在镜像前面指定仓库地址( `Registry`), 如果不指定，则 Docker 会使用您默认配置的仓库地址。例如上面，由于我配置的是国内 `docker.io` 的仓库地址，我在 `pull` 的时候，docker 会默认为我加上 `docker.io/library` 的前缀。

如：当我执行 `docker pull mysql:5.7` 命令时，实际上相当于 `docker pull docker.io/mysql:5.7`，如果您未自定义配置仓库，则默认在下载的时候，会在镜像前面加上 DockerHub 的地址。

Docker 通过前缀地址的不同，来保证不同仓库中，重名镜像的唯一性。

**PULL 子命令**

命令行中输入：

```
docker pull --help
```

会得到如下信息：

```
root@ubuntuweb:/# docker pull --help
Usage:  docker pull [OPTIONS] NAME[:TAG|@DIGEST]
Pull an image or a repository from a registry
Options:  -a, --all-tags                Download all tagged images in the repository      --disable-content-trust   Skip image verification (default true)      --help                    Print usage
```

我们可以看到主要支持的子命令有：

1. `-a,--all-tags=true|false`: 是否获取仓库中所有镜像，默认为否；
2. `--disable-content-trust`: 跳过镜像内容的校验，默认为 true;

### Docker 查看镜像信息

**images 命令列出镜像**

通过使用如下两个命令，列出本机已有的镜像：

```
docker images
```

或：

```
docker image ls
```

如下图所示：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848631.png)

对上述红色标注的字段做一下解释：

- **REPOSITORY**: 来自于哪个仓库；
- **TAG**: 镜像的标签信息，比如 5.7、latest 表示不同的版本信息；
- **IMAGE ID**: 镜像的 ID, 如果您看到两个 ID 完全相同，那么实际上，它们指向的是同一个镜像，只是标签名称不同罢了；
- **CREATED**: 镜像最后的更新时间；
- **SIZE**: 镜像的大小，优秀的镜像一般体积都比较小，这也是我更倾向于使用轻量级的 alpine 版本的原因；

> 注意：图中的镜像大小信息只是逻辑上的大小信息，因为一个镜像是由多个镜像层（ `layer`）组成的，而相同的镜像层本地只会存储一份，所以，真实情况下，占用的物理存储空间大小，可能会小于逻辑大小。由于 Docker 镜像是多层存储结构，并且可以继承、复用，因此不同镜像可能会因为使用相同的基础镜像，从而拥有共同的层。由于 Docker 使用 Union FS，相同的层只需要保存一份即可，因此实际镜像硬盘占用空间很可能要比这个列表镜像大小的总和要小的多。

你可以通过以下命令来便捷的查看镜像、容器、数据卷所占用的空间。

``` lsl
# docker system df
TYPE                TOTAL               ACTIVE              SIZE                RECLAIMABLE
Images              7                   3                   514.4MB             415.2MB (80%)
Containers          3                   0                   512.1kB             512.1kB (100%)
Local Volumes       1                   1                   105B                0B (0%)
Build Cache         0                   0                   0B                  0B
```

**使用 tag 命令为镜像添加标签**

通常情况下，为了方便在后续工作中，快速地找到某个镜像，我们可以使用 `docker tag` 命令，为本地镜像添加一个新的标签。为 `mysql` 镜像，添加新的镜像标签 `allen_mysql:5.7`。然后使用 `docker images` 命令，查看本地镜像。如下图所示：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848584.png)

可以看到，本地多了一个 `qymua_mysql:5.7` 的镜像。细心的你一定还会发现， `qymua_mysql:5.7` 和 `mysql:5.7` 的镜像 ID 是一模一样的，说明它们是同一个镜像，只是别名不同而已。

`docker tag` 命令功能更像是, 为指定镜像添加快捷方式一样。

**使用 inspect 命令查看镜像详细信息**

通过 `docker inspect` 命令，我们可以获取镜像的详细信息，其中，包括创建者，各层的数字摘要等。

```
docker inspect mysql:5.7
```

`docker inspect` 返回的是 `JSON` 格式的信息，如果您想获取其中指定的一项内容，可以通过 `-f` 来指定，如获取镜像大小：

```
docker inspect -f {{".Size"}} mysql:5.7
```

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848656.png)

**使用 history 命令查看镜像历史**

前面的小节中，我们知道了，一个镜像是由多个层（layer）组成的，那么，我们要如何知道各个层的具体内容呢？

通过 `docker history` 命令，可以列出各个层（layer）的创建信息，如我们查看 `mysql:5.7` 的各层信息：

```
docker history mysql:5.7
```

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849335.png)

可以看到，上面过长的信息，为了方便展示，后面都省略了，如果您想要看具体信息，可以通过添加 `--no-trunc` 选项，如下面命令：

```
docker history --no-trunc mysql:5.7
```

**虚悬镜像**

上面的镜像列表中，还可以看到一个特殊的镜像，这个镜像既没有仓库名，也没有标签，均为 `<none>`：

``` lsl
<none>               <none>              00285df0df87        5 days ago          342 MB
```

这个镜像原本是有镜像名和标签的，原来为 `mongo:3.2`，随着官方镜像维护，发布了新版本后，重新 `docker pull mongo:3.2` 时，mongo:3.2 这个镜像名被转移到了新下载的镜像身上，而旧的镜像上的这个名称则被取消，从而成为了 `<none>`。除了 `docker pull` 可能导致这种情况，`docker build` 也同样可以导致这种现象。由于新旧镜像同名，旧镜像名称被取消，从而出现仓库名、标签均为 `<none>` 的镜像。这类无标签镜像也被称为 **虚悬镜像(dangling image)** ，可以用下面的命令专门显示这类镜像：

``` 
$ docker image ls -f dangling=true
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              00285df0df87        5 days ago          342 MB
```

一般来说，虚悬镜像已经失去了存在的价值，是可以随意删除的，可以用下面的命令删除。

``` shell
$ docker image prune
```

**中间层镜像**

为了加速镜像构建、重复利用资源，Docker 会利用 **中间层镜像**。所以在使用一段时间后，可能会看到一些**依赖**的中间层镜像。默认的 `docker image ls` 列表中只会显示顶层镜像，如果希望显示包括中间层镜像在内的所有镜像的话，需要加 `-a` 参数。


``` shell
$ docker image ls -a
```

**列出部分镜像**

不加任何参数的情况下，docker image ls 会列出所有顶层镜像，但是有时候我们只希望列出部分镜像。docker image ls 有好几个参数可以帮助做到这个事情。

根据仓库名列出镜像

``` lsl
$ docker image ls ubuntu
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              18.04               f753707788c5        4 weeks ago         127 MB
ubuntu              latest              f753707788c5        4 weeks ago         127 MB
```
列出特定的某个镜像，也就是说指定仓库名和标签

``` sqf
$ docker image ls ubuntu:18.04
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              18.04               f753707788c5        4 weeks ago         127 MB
```
除此以外，docker image ls 还支持强大的过滤器参数 --filter，或者简写 -f。之前我们已经看到了使用过滤器来列出虚悬镜像的用法，它还有更多的用法。比如，我们希望看到在 mongo:3.2 之后建立的镜像，可以用下面的命令：

``` tap
$ docker image ls -f since=mongo:3.2
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
redis               latest              5f515359c7f8        5 days ago          183 MB
nginx               latest              05a60462f8ba        5 days ago          181 MB
```
想查看某个位置之前的镜像也可以，只需要把 since 换成 before 即可。

此外，如果镜像构建时，定义了 LABEL，还可以通过 LABEL 来过滤。

``` 
$ docker image ls -f label=com.example.version=0.1
...
```

**以特定格式显示**

默认情况下，docker image ls 会输出一个完整的表格，但是我们并非所有时候都会需要这些内容。比如，刚才删除虚悬镜像的时候，我们需要利用 `docker image ls` 把所有的虚悬镜像的 ID 列出来，然后才可以交给 `docker image rm` 命令作为参数来删除指定的这些镜像，这个时候就用到了 `-q` 参数。

``` 
$ docker image ls -q
5f515359c7f8
05a60462f8ba
fe9198c04d62
00285df0df87
f753707788c5
f753707788c5
1e0c3dd64ccd
```

### Docker 搜索镜像

**search 命令**

您可以通过下面命令进行搜索：

```
docker search [option] keyword
```

比如，您想搜索仓库中 `mysql` 相关的镜像，可以输入如下命令：

```
docker search mysql
```

**search 子命令**

命令行输入 `docker search--help`, 输出如下：

```
Usage:  docker search [OPTIONS] TERM
Search the Docker Hub for images
Options:  -f, --filter filter   Filter output based on conditions provided      --help            Print usage      --limit int       Max number of search results (default 25)      --no-index        Don't truncate output      --no-trunc        Don't truncate output
```

可以看到 `search` 支持的子命令有：

- `-f,--filter filter`: 过滤输出的内容；
- `--limitint`：指定搜索内容展示个数;
- `--no-index`: 不截断输出内容；
- `--no-trunc`：不截断输出内容；

举个列子，比如我们想搜索官方提供的 mysql 镜像，命令如下：

```
docker search --filter=is-offical=true mysql
```

再比如，我们想搜索 Stars 数超过 100 的 mysql 镜像：

```
docker search --filter=stars=100 mysql
```

### Docker 运行镜像

有了镜像后，我们就能够以这个镜像为基础启动并运行一个容器。以上面的 `ubuntu:18.04` 为例，如果我们打算启动里面的 bash 并且进行交互式操作的话，可以执行下面的命令。

``` makefile
$ docker run -it --rm ubuntu:18.04 /bin/bash

root@e7009c6ce357:/# cat /etc/os-release
NAME="Ubuntu"
VERSION="18.04.1 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.1 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```
- -it：这是两个参数，一个是 -i：交互式操作，一个是 -t 终端。我们这里打算进入 bash 执行一些命令并查看返回结果，因此我们需要交互式终端。
- --rm：这个参数是说容器退出后随之将其删除。默认情况下，为了排障需求，退出的容器并不会立即删除，除非手动 docker rm。我们这里只是随便执行个命令，看看结果，不需要排障和保留结果，因此使用 --rm 可以避免浪费空间。
- ubuntu:18.04：这是指用 ubuntu:18.04 镜像为基础来启动容器。
- bash：放在镜像名后的是 命令，这里我们希望有个交互式 Shell，因此用的是 bash。

进入容器后，我们可以在 Shell 下操作，执行任何所需的命令。这里，我们执行了 cat /etc/os-release，这是 Linux 常用的查看当前系统版本的命令，从返回的结果可以看到容器内是 Ubuntu 18.04.1 LTS 系统。

最后我们通过 exit 退出了这个容器。

### Docker 删除镜像

**通过标签删除镜像**

通过如下两个都可以删除镜像：

```
docker rmi [image]
```

或者：

```
docker image rm [image]
```

支持的子命令如下：

- `-f,-force`: 强制删除镜像，即便有容器引用该镜像；
- `-no-prune`: 不要删除未带标签的父镜像；

例如，我们想删除上章节创建的 `qymua_mysql:5.7` 镜像，命令如下：

```shell
docker rmi qymua_mysql:5.7
```

**实际上，当同一个镜像拥有多个标签时，执行 `docker rmi` 命令，只是会删除了该镜像众多标签中，您指定的标签而已，并不会影响原始的那个镜像文件。**

那么，如果某个镜像不存在多个标签，当且仅当只有一个标签时，执行删除命令时，您就要小心了，这会彻底删除镜像。

**通过 ID 删除镜像**

除了通过标签名称来删除镜像，我们还可以通过制定镜像 ID, 来删除镜像，如：

```
docker rmi ee7cbd482336
```

一旦制定了通过 ID 来删除镜像，它会先尝试删除所有指向该镜像的标签，然后在删除镜像本身。

**删除镜像的限制**

删除镜像很简单，但也不是我们何时何地都能删除的，它存在一些限制条件。

当通过该镜像创建的容器未被销毁时，镜像是无法被删除的。

除非通过添加 `-f` 子命令，也就是强制删除，才能移除掉该镜像

```
docker rmi -f mysql:5.7
```

但是，一般不推荐这样暴力的做法，正确的做法应该是：

1. 先删除引用这个镜像的容器；
2. 再删除这个镜像；

也就是，根据引用该镜像的容器 ID ( `9d59e2278553`), 执行删除命令：

```
docker rm 9d59e2278553
```

然后，再执行删除镜像的命令：

```
docker rmi 5cb3aa00f899
```



**清理镜像**

我们在使用 Docker 一段时间后，系统一般都会残存一些临时的、没有被使用的镜像文件，可以通过以下命令进行清理：

```
docker image prune
```

它支持的子命令有：

- `-a,--all`: 删除所有没有用的镜像，而不仅仅是临时文件；
- `-f,--force`：强制删除镜像文件，无需弹出提示确认；

### Docker 创建镜像

Docker 创建镜像主要有三种：

1. 基于已有的镜像创建；
2. 基于 Dockerfile 来创建；
3. 基于本地模板来导入；

我们将主要介绍常用的 1，2 两种。

**基于已有的镜像创建**

通过如下命令来创建：

```
docker container commit
```

支持的子命令如下：

- `-a,--author`="": 作者信息；
- `-c,--change`=[]: 可以在提交的时候执行 Dockerfile 指令，如 CMD、ENTRYPOINT、ENV、EXPOSE、LABEL、ONBUILD、USER、VOLUME、WORIR 等；
- `-m,--message`="": 提交信息；
- `-p,--pause`=true: 提交时，暂停容器运行。

接下来，基于本地已有的 Ubuntu 镜像，创建一个新的镜像：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848892.png)

首先，让我将它运行起来，并在其中创建一个 test.txt 文件：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849275.png)

命令如下：

```
root@ubuntuweb:/# docker run -it ubuntu:latest /bin/bash
root@437b2645a468:/# touch test.txt
root@437b2645a468:/# exit
```

创建完 test.txt 文件后，需要记住标注的容器 ID: `a0a0c8cfec3a`, 用它来提交一个新的镜像(**PS: 你也可以通过名称来提交镜像，这里只演示通过 ID 的方式**)。

执行命令：

```
docker container commit -m "Added test.txt file" -a "QYMUA" 437b2645a468 test:0.1
```

提交成功后，会返回新创建的镜像 ID 信息，如下图所示：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848872.png)

再次查看本地镜像信息，可以看到新创建的 `test:0.1` 镜像了：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848665.png)

**基于 Dockerfile 创建**

通过 Dockerfile 的方式来创建镜像，是最常见的一种方式了，也是比较推荐的方式。Dockerfile 是一个文本指令文件，它描述了是如何基于一个父镜像，来创建一个新镜像的过程。

下面让我们来编写一个简单的 Dockerfile 文件，它描述了基于 Ubuntu 父镜像，安装 Python3 环境的镜像：

```
FROM ubuntu:latest
LABEL version="1.0" maintainer="QYMUA <Qymua@github>"
RUN apt-get update && \    apt-get install -y python3 && \    apt-get clean && \    rm -rf /var/lib/apt/lists/*
```

创建完成后，通过这个 Dockerfile 文件，来构建新的镜像，执行命令：

```
docker image build -t python:3 .
```

**注意：** 命令的最后有个点，如果不加的话，会构建不成功 

### Docker 导出&加载镜像

通常我们会有下面这种需求，需要将镜像分享给别人，这个时候，我们可以将镜像导出成 tar 包，别人直接通过加载这个 tar 包，快速地将镜像引入到本地镜像库。

要想使用这两个功能，主要是通过如下两个命令：

1. `docker save`
2. `docker load`

**导出镜像**

例如，我们想要将 test:0.1 镜像导出来，执行命令：

```
docker save -o test_0.1.tar test:0.1
```

执行成功后，查看当前目录：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848959.png)

可以看到 `test_0.1.tar` 镜像文件已经生成

**加载镜像**

别人拿到了这个 `tar` 包后，要如何导入到本地的镜像库呢？

通过执行如下命令：

```
docker load -i test_0.1.tar
```

或者：

```
docker load < test_0.1.tar
```

导入成功后，查看本地镜像信息，你就可以获得别人分享的镜像了！怎么样，是不是很方便呢！

### Docker 上传镜像

以上传到 Docker Hub 上为示例，演示 Docker 如何上传镜像。

**获取 Docker ID**

想要上传镜像到 Docker Hub 上，首先，我们需要注册 Docker Hub 账号。打开 Docker Hub 网址 https://hub.docker.com，开始注册：

使用方法和github大致相同，创建仓库即可

**上传镜像**

进入命令行，**用我们刚刚获取的 Docker ID 以及密码登录**，执行命令：

```
docker login
```

命令行登录 Docker ID

登录成功后，我们开始准备上传本地的 镜像：

首先，我们对其打一个新的标签，**前缀与我们新创建的 Docker ID 、仓库名保持一致**:

```
docker tag test:0.1 dockerID/test:0.1
```

查看本地信息，可以看到，标签打成功了。执行命令：

```
docker push dockerID/test:0.1
```

## 操作Docker

### Docker常用命令

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472848960.png)



**Search images**

``` shell
$ sudo docker search ubuntu
```

当我们需要拉取一个 docker 镜像，我们可以用如下命令：

``` nginx
docker pull image_name
```

`image_name` 为镜像的名称，而如果我们想从 Docker Hub 上去下载某个镜像，我们可以使用以下命令：

``` css
docker pull centos:latest
```

`centos:lastest` 是镜像的名称， Docker daemon 发现本地没有我们需要的镜像，会自动去 Docker Hub 上去下载镜像，下载完成后，该镜像被默认保存到 `/var/lib/docker` 目录下。

接着我们如果想查看下主机下存在多少镜像，我们可以用如下命令：

``` ebnf
docker images
```

我们要想知道当前有哪些容器在运行，我们可以用如下命令：

``` bash
docker ps -a
```

`-a` 是查看当前所有的容器，包括未运行的

我们该如何去对一个容器进行启动，重启和停止呢？我们可以用如下命令：

``` crmsh
docker start container_name/container_id
docker restart container_name/container_id
docker stop container_name/container_id
```

这个时候我们如果想进入到这个容器中，我们可以使用 attach 命令：

``` r
docker attach container_name/container_id
```
利用dockerfile构建镜像：

``` armasm
docker build -t qymua/nginx_web:0.1 .
```
解释一下， -t 是为新镜像设置仓库和名称，其中 qymua 为仓库名， nginx_web 为镜像名， :0.1 为标签（不添加为默认 latest ）

那如果我们想运行这个容器中的镜像的话，并且调用镜像里面的 bash ，我们可以使用如下命令：

``` stylus
docker run -t -i container_name/container_id /bin/bash
```

- docker run - 运行一个容器
- -t - 分配一个（伪）tty (link is external)
- -i - 交互模式 (so we can interact with it)
- ubuntu:14.04 - 使用 ubuntu 基础镜像 14.04
- /bin/bash - 运行命令 bash shell

那如果这个时候，我们想删除指定镜像的话，由于 image 被某个 container 引用（拿来运行），如果不将这个引用的 container 销毁（删除），那 image 肯定是不能被删除。我们首先得先去停止这个容器：

``` vim
docker ps
docker stop container_name/container_id
```

然后我们用如下命令去删除这个容器：

``` stata
docker rm container_name/container_id
```

然后这个时候我们再去删除这个镜像：

``` nginx
docker rmi image_name
```

此时，常用的 Docker 相关的命令就讲到这里为止了，我们在后续的文章中还会反复地提到这些命令。

### Docker命令查询

**基本语法**

Docker 命令有两大类，客户端命令和服务端命令。前者是主要的操作接口，后者用来启动 Docker Daemon。

- 客户端命令：基本命令格式为 docker [OPTIONS] COMMAND [arg...]；

- 服务端命令：基本命令格式为 dockerd [OPTIONS]。

可以通过 man docker 或 docker help 来查看这些命令。


**客户端命令选项**

- --config=""：指定客户端配置文件，默认为 ~/.docker；
- -D=true|false：是否使用 debug 模式。默认不开启；
- -H, --host=[]：指定命令对应 Docker 守护进程的监听接口，可以为 unix 套接字 unix:///path/to/socket，文件句柄 fd://socketfd 或 tcp 套接字 tcp://[host[:port]]，默认为 unix:///var/run/docker.sock；
- -l, --log-level="debug|info|warn|error|fatal"：指定日志输出级别；
- --tls=true|false：是否对 Docker 守护进程启用 TLS 安全机制，默认为否；
- --tlscacert=/.docker/ca.pem：TLS CA 签名的可信证书文件路径；
- --tlscert=/.docker/cert.pem：TLS 可信证书文件路径；
- --tlscert=/.docker/key.pem：TLS 密钥文件路径；
- --tlsverify=true|false：启用 TLS 校验，默认为否。

**Docker命令帮助注释**

docker command

``` 
$ sudo docker   # docker 命令帮助

Commands:
    attach    Attach to a running container                 # 当前 shell 下 attach 连接指定运行镜像
    build     Build an image from a Dockerfile              # 通过 Dockerfile 定制镜像
    commit    Create a new image from a container's changes # 提交当前容器为新的镜像
    cp        Copy files/folders from the containers filesystem to the host path
              # 从容器中拷贝指定文件或者目录到宿主机中
    create    Create a new container                        # 创建一个新的容器，同 run，但不启动容器
    diff      Inspect changes on a container's filesystem   # 查看 docker 容器变化
    events    Get real time events from the server          # 从 docker 服务获取容器实时事件
    exec      Run a command in an existing container        # 在已存在的容器上运行命令
    export    Stream the contents of a container as a tar archive   
              # 导出容器的内容流作为一个 tar 归档文件[对应 import ]
    history   Show the history of an image                  # 展示一个镜像形成历史
    images    List images                                   # 列出系统当前镜像
    import    Create a new filesystem image from the contents of a tarball  
              # 从tar包中的内容创建一个新的文件系统映像[对应 export]
    info      Display system-wide information               # 显示系统相关信息
    inspect   Return low-level information on a container   # 查看容器详细信息
    kill      Kill a running container                      # kill 指定 docker 容器
    load      Load an image from a tar archive              # 从一个 tar 包中加载一个镜像[对应 save]
    login     Register or Login to the docker registry server   
              # 注册或者登陆一个 docker 源服务器
    logout    Log out from a Docker registry server         # 从当前 Docker registry 退出
    logs      Fetch the logs of a container                 # 输出当前容器日志信息
    port      Lookup the public-facing port which is NAT-ed to PRIVATE_PORT
              # 查看映射端口对应的容器内部源端口
    pause     Pause all processes within a container        # 暂停容器
    ps        List containers                               # 列出容器列表
    pull      Pull an image or a repository from the docker registry server
              # 从docker镜像源服务器拉取指定镜像或者库镜像
    push      Push an image or a repository to the docker registry server
              # 推送指定镜像或者库镜像至docker源服务器
    restart   Restart a running container                   # 重启运行的容器
    rm        Remove one or more containers                 # 移除一个或者多个容器
    rmi       Remove one or more images                 
              # 移除一个或多个镜像[无容器使用该镜像才可删除，否则需删除相关容器才可继续或 -f 强制删除]
    run       Run a command in a new container
              # 创建一个新的容器并运行一个命令
    save      Save an image to a tar archive                # 保存一个镜像为一个 tar 包[对应 load]
    search    Search for an image on the Docker Hub         # 在 docker hub 中搜索镜像
    start     Start a stopped containers                    # 启动容器
    stop      Stop a running containers                     # 停止容器
    tag       Tag an image into a repository                # 给源中镜像打标签
    top       Lookup the running processes of a container   # 查看容器中运行的进程信息
    unpause   Unpause a paused container                    # 取消暂停容器
    version   Show the docker version information           # 查看 docker 版本号
    wait      Block until a container stops, then print its exit code   
              # 截取容器停止时的退出状态值
Run 'docker COMMAND --help' for more information on a command.

```

docker option

``` gauss
Usage of docker:
  --api-enable-cors=false                Enable CORS headers in the remote API                      # 远程 API 中开启 CORS 头
  -b, --bridge=""                        Attach containers to a pre-existing network bridge         # 桥接网络
                                           use 'none' to disable container networking
  --bip=""                               Use this CIDR notation address for the network bridge's IP, not compatible with -b
                                         # 和 -b 选项不兼容，具体没有测试过
  -d, --daemon=false                     Enable daemon mode                                         # daemon 模式
  -D, --debug=false                      Enable debug mode                                          # debug 模式
  --dns=[]                               Force docker to use specific DNS servers                   # 强制 docker 使用指定 dns 服务器
  --dns-search=[]                        Force Docker to use specific DNS search domains            # 强制 docker 使用指定 dns 搜索域
  -e, --exec-driver="native"             Force the docker runtime to use a specific exec driver     # 强制 docker 运行时使用指定执行驱动器
  --fixed-cidr=""                        IPv4 subnet for fixed IPs (ex: 10.20.0.0/16)
                                           this subnet must be nested in the bridge subnet (which is defined by -b or --bip)
  -G, --group="docker"                   Group to assign the unix socket specified by -H when running in daemon mode
                                           use '' (the empty string) to disable setting of a group
  -g, --graph="/var/lib/docker"          Path to use as the root of the docker runtime              # 容器运行的根目录路径
  -H, --host=[]                          The socket(s) to bind to in daemon mode                    # daemon 模式下 docker 指定绑定方式[tcp or 本地 socket]
                                           specified using one or more tcp://host:port, unix:///path/to/socket, fd://* or fd://socketfd.
  --icc=true                             Enable inter-container communication                       # 跨容器通信
  --insecure-registry=[]                 Enable insecure communication with specified registries (no certificate verification for HTTPS and enable HTTP fallback) (e.g., localhost:5000 or 10.20.0.0/16)
  --ip="0.0.0.0"                         Default IP address to use when binding container ports     # 指定监听地址，默认所有 ip
  --ip-forward=true                      Enable net.ipv4.ip_forward                                 # 开启转发
  --ip-masq=true                         Enable IP masquerading for bridge's IP range
  --iptables=true                        Enable Docker's addition of iptables rules                 # 添加对应 iptables 规则
  --mtu=0                                Set the containers network MTU                             # 设置网络 mtu
                                           if no value is provided: default to the default route MTU or 1500 if no default route is available
  -p, --pidfile="/var/run/docker.pid"    Path to use for daemon PID file                            # 指定 pid 文件位置
  --registry-mirror=[]                   Specify a preferred Docker registry mirror                  
  -s, --storage-driver=""                Force the docker runtime to use a specific storage driver  # 强制 docker 运行时使用指定存储驱动
  --selinux-enabled=false                Enable selinux support                                     # 开启 selinux 支持
  --storage-opt=[]                       Set storage driver options                                 # 设置存储驱动选项
  --tls=false                            Use TLS; implied by tls-verify flags                       # 开启 tls
  --tlscacert="/root/.docker/ca.pem"     Trust only remotes providing a certificate signed by the CA given here
  --tlscert="/root/.docker/cert.pem"     Path to TLS certificate file                               # tls 证书文件位置
  --tlskey="/root/.docker/key.pem"       Path to TLS key file                                       # tls key 文件位置
  --tlsverify=false                      Use TLS and verify the remote (daemon: verify client, client: verify daemon) # 使用 tls 并确认远程控制主机
  -v, --version=false                    Print version information and quit                         # 输出 docker 版本信息
```

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849270.png)

Docker 提供了一套简单实用的命令来创建和更新镜像，我们可以通过网络直接下载一个已经创建好了的应用镜像，并通过 Docker RUN 命令就可以直接使用。当镜像通过 RUN 命令运行成功后，这个运行的镜像就是一个 Docker 容器啦，容器可以理解为一个轻量级的沙箱， Docker 利用容器来运行和隔离应用，容器是可以被启动、停止、删除的，这并不会影响 Docker 镜像。

我们可以看看下面这幅图：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849211.png)

### 操作容器

**启动容器**

启动容器有两种方式，一种是基于镜像新建一个容器并启动，另外一个是将在终止状态（stopped）的容器重新启动。

因为 Docker 的容器实在太轻量级了，很多时候用户都是随时删除和新创建容器。

**新建并启动**

所需要的命令主要为 `docker run`。

>docker build -t 是利用Dockerfile 构建镜像，这个时候可以使用 –-name 来给自己的镜像命名;
>docker run 是利用依据这个镜像构建容器，这个时候可以使用 –-name 命名你的容器;
>如果容器需要修改配置文件，我们可以选择挂载/挂载数据卷的方式，也可以直接COPY/ADD来覆盖

例如，下面的命令输出一个 “Hello World”，之后终止容器。

``` dockerfile
$ docker run --name wubantu ubuntu:18.04 /bin/echo 'Hello world'
Hello world
```
这跟在本地直接执行 `/bin/echo 'hello world'` 几乎感觉不出任何区别。

下面的命令则启动一个 bash 终端，允许用户进行交互。

``` elixir
$ docker run -t -i ubuntu:18.04 /bin/bash
root@af8bae53bdd3:/#
```
其中，-t 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上， -i 则让容器的标准输入保持打开。

在交互模式下，用户可以通过所创建的终端来输入命令，例如

``` shell
root@af8bae53bdd3:/# pwd
/
root@af8bae53bdd3:/# ls
bin boot dev etc home lib lib64 media mnt opt proc root run sbin srv sys tmp usr var
```
当利用 docker run 来创建容器时，Docker 在后台运行的标准操作包括：

- 检查本地是否存在指定的镜像，不存在就从公有仓库下载
- 利用镜像创建并启动一个容器
- 分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
- 从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
- 从地址池配置一个 ip 地址给容器
- 执行用户指定的应用程序
- 执行完毕后容器被终止

**启动已终止容器**

可以利用 `docker container start` 命令，直接将一个已经终止的容器启动运行。

容器的核心为所执行的应用程序，所需要的资源都是应用程序运行所必需的。除此之外，并没有其它的资源。可以在伪终端中利用 ps 或 top 来查看进程信息。

``` shell
root@ba267838cc1b:/# ps
  PID TTY          TIME CMD
    1 ?        00:00:00 bash
   11 ?        00:00:00 ps
```
**后台运行**

更多的时候，需要让 Docker 在后台运行而不是直接把执行命令的结果输出在当前宿主机下。此时，可以通过添加 `-d` 参数来实现。

下面举两个例子来说明一下。

如果不使用 `-d` 参数运行容器。

``` dockerfile
$ docker run ubuntu:18.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
hello world
hello world
hello world
hello world
```
容器会把输出的结果 (STDOUT) 打印到宿主机上面

如果使用了 -d 参数运行容器。

``` dockerfile
$ docker run -d ubuntu:18.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
77b2dc01fe0f3f1265df143181e7b9af5e05279a884f4776ee75350ea9d8017a
```

此时容器会在后台运行并不会把输出的结果 (STDOUT) 打印到宿主机上面(输出结果可以用 docker logs 查看)。

**注**： 容器是否会长久运行，是和 docker run 指定的命令有关，和 -d 参数无关。

使用 `-d` 参数启动后会返回一个唯一的 id，也可以通过 `docker container ls` 命令来查看容器信息。

``` stata
$ docker container ls
CONTAINER ID  IMAGE         COMMAND               CREATED        STATUS       PORTS NAMES
77b2dc01fe0f  ubuntu:18.04  /bin/sh -c 'while tr  2 minutes ago  Up 1 minute        agitated_wright
```
要获取容器的输出信息，可以通过 `docker container logs` 命令。

``` gams
$ docker container logs [container ID or NAMES]
hello world
hello world
hello world
. . .
```

**终止容器**

可以使用 `docker container stop` 来终止一个运行中的容器。

此外，当 Docker 容器中指定的应用终结时，容器也自动终止。

终止状态的容器可以用 docker container ls -a 命令看到。例如

``` stata
docker container ls -a
CONTAINER ID        IMAGE                    COMMAND                CREATED             STATUS                          PORTS               NAMES
ba267838cc1b        ubuntu:18.04             "/bin/bash"            30 minutes ago      Exited (0) About a minute ago                       trusting_newton
98e5efa7d997        training/webapp:latest   "python app.py"        About an hour ago   Exited (0) 34 minutes ago                           backstabbing_pike
```
处于终止状态的容器，可以通过 `docker container start` 命令来重新启动。

此外，`docker container restart` 命令会将一个运行态的容器终止，然后再重新启动它。

> 好像也可以直接docker start/stop/restart ID

**文件双向传输**

如果是容器传输文件到本地的话，反过来就好了：
``` avrasm
docker cp ID全称:容器文件路径 本地路径
```
**好用的命令**

停止并删除所有的容器

``` vim
docker stop $(docker ps -q) & docker rm $(docker ps -aq)
```

删除所有的镜像

``` javascript
docker rmi $(docker images -q)
```

**进入容器**

在使用 `-d` 参数时，容器启动后会进入后台。

某些时候需要进入容器进行操作，包括使用 `docker attach` 命令或 `docker exec` 命令，推荐大家使用 `docker exec` 命令，原因会在下面说明。

`attach 命令`

下面示例如何使用 docker attach 命令。

``` llvm
$ docker run -dit ubuntu
243c32535da7d142fb0e6df616a3c3ada0b8ab417937c853a9e1c251f499f550

$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
243c32535da7        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           nostalgic_hypatia

$ docker attach 243c
root@243c32535da7:/#
```
> 注意： 如果从这个 stdin 中 exit，会导致容器的停止。

`exec 命令`

docker exec 后边可以跟多个参数，这里主要说明 -i -t 参数。

只用 -i 参数时，由于没有分配伪终端，界面没有我们熟悉的 Linux 命令提示符，但命令执行结果仍然可以返回。

当 `-i -t` 参数一起使用时，则可以看到我们熟悉的 Linux 命令提示符。

``` shell
$ docker run -dit ubuntu
69d137adef7a8a689cbcb059e94da5489d3cddd240ff675c640c8d96e84fe1f6

$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
69d137adef7a        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           zealous_swirles

$ docker exec -i 69d1 bash
ls
bin
boot
dev
...

$ docker exec -it 69d1 bash
root@69d137adef7a:/#
```

>如果从这个 stdin 中 exit，不会导致容器的停止。这就是为什么推荐大家使用 docker exec 的原因。

*更多参数说明请使用 docker exec --help 查看。*

**导出和导入容器**

如果要导出本地某个容器，可以使用 `docker export` 命令。

``` shell
$ docker container ls -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                    PORTS               NAMES
7691a814370e        ubuntu:18.04        "/bin/bash"         36 hours ago        Exited (0) 21 hours ago                       test
$ docker export 7691a814370e > ubuntu.tar
```
这样将导出容器快照到本地文件。

可以使用 `docker import` 从容器快照文件中再导入为镜像，例如

``` stata
$ cat ubuntu.tar | docker import - test/ubuntu:v1.0
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED              VIRTUAL SIZE
test/ubuntu         v1.0                9d37a6082e97        About a minute ago   171.3 MB
```

此外，也可以通过指定 URL 或者某个目录来导入，例如

``` groovy
$ docker import http://example.com/exampleimage.tgz example/imagerepo
```

>注：用户既可以使用 docker load 来导入镜像存储文件到本地镜像库，也可以使用 docker import 来导入一个容器快照到本地镜像库。这两者的区别在于容器快照文件将丢弃所有的历史记录和元数据信息（即仅保存容器当时的快照状态），而镜像存储文件将保存完整记录，体积也要大。此外，从容器快照文件导入时可以重新指定标签等元数据信息。

**删除容器**

可以使用 docker container rm 来删除一个处于终止状态的容器。例如

``` shell
$ docker container rm  trusting_newton
trusting_newton
```
如果要删除一个运行中的容器，可以添加 -f 参数。Docker 会发送 SIGKILL 信号给容器。

清理所有处于终止状态的容器

用 `docker container ls -a` 命令可以查看所有已经创建的包括终止状态的容器，如果数量太多要一个个删除可能会很麻烦，用下面的命令可以清理掉所有处于终止状态的容器。

``` shell
$ docker container prune
```

### 使用网络

**外部访问容器**

容器中可以运行一些网络应用，要让外部也可以访问这些应用，可以通过 `-P` 或 `-p` 参数来指定端口映射。

当使用 -P 标记时，Docker 会随机映射一个 49000~49900 的端口到内部容器开放的网络端口。

使用 docker container ls 可以看到，本地主机的 49155 被映射到了容器的 5000 端口。此时访问本机的 49155 端口即可访问容器内 web 应用提供的界面。

``` shell
$ docker run -d -P training/webapp python app.py

$ docker container ls -l
CONTAINER ID  IMAGE                   COMMAND       CREATED        STATUS        PORTS                    NAMES
bc533791f3f5  training/webapp:latest  python app.py 5 seconds ago  Up 2 seconds  0.0.0.0:49155->5000/tcp  nostalgic_morse
```
同样的，可以通过 `docker logs` 命令来查看应用的信息。

``` accesslog
$ docker logs -f nostalgic_morse
* Running on http://0.0.0.0:5000/
10.0.2.2 - - [23/May/2014 20:16:31] "GET / HTTP/1.1" 200 -
10.0.2.2 - - [23/May/2014 20:16:31] "GET /favicon.ico HTTP/1.1" 404 -
```

`-p` 则可以指定要映射的端口，并且，在一个指定端口上只可以绑定一个容器。支持的格式有 `ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort`。

**映射所有接口地址**

使用 hostPort:containerPort 格式本地的 5000 端口映射到容器的 5000 端口，可以执行

``` shell
$ docker run -d -p 5000:5000 training/webapp python app.py
```
此时默认会绑定本地所有接口上的所有地址。

**映射到指定地址的指定端口**

可以使用 `ip:hostPort:containerPort` 格式指定映射使用一个特定地址，比如 localhost 地址 127.0.0.1

``` shell
$ docker run -d -p 127.0.0.1:5000:5000 training/webapp python app.py
```
**映射到指定地址的任意端口**

使用 `ip::containerPort` 绑定 localhost 的任意端口到容器的 5000 端口，本地主机会自动分配一个端口。

$ docker run -d -p 127.0.0.1::5000 training/webapp python app.py

还可以使用 `udp` 标记来指定 `udp` 端口

``` shell
$ docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py
```
**查看映射端口配置**

使用 `docker port` 来查看当前映射的端口配置，也可以查看到绑定的地址

``` x86asm
$ docker port nostalgic_morse 5000
127.0.0.1:49155.
```
> 注意：
> 容器有自己的内部网络和 ip 地址（使用 docker inspect 可以获取所有的变量，Docker 还可以有一个可变的网络配置。）
> -p 标记可以多次使用来绑定多个端口

``` haml
$ docker run -d \
    -p 5000:5000 \
    -p 3000:80 \
    training/webapp \
    python app.py
```
可以查看容器的具体IP地址，如果输出是空的说明没有配置IP地址
`docker inspect --format '{{ .NetworkSettings.IPAddress }}' 容器id`

## Dockerfile

### Dockerfile概念

前面我们已经提到了 Docker 的一些基本概念。以 `CTF 选手`的角度来看，我们可以去使用 Dockerfile 定义镜像，依赖镜像来运行容器，可以去模拟出一个真实的漏洞场景。因此毫无疑问的说， Dockerfile 是镜像和容器的关键，并且 Dockerfile 还可以很轻易的去定义镜像内容，说了这么多，那么 Dockerfile 到底是个什么东西呢？

Dockerfile 是自动构建 docker 镜像的配置文件， 用户可以使用 Dockerfile 快速创建自定义的镜像。Dockerfile 中的命令非常类似于 linux 下的 shell 命令。

我们可以通过下面这幅图来直观地感受下 Docker 镜像、容器和 Dockerfile 三者之间的关系。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849293.png)

我们从上图中可以看到， Dockerfile 可以自定义镜像，通过 Docker 命令去运行镜像，从而达到启动容器的目的。

Dockerfile 是由一行行命令语句组成，并且支持已 `#` 开头的注释行。

一般来说，我们可以将 Dockerfile 分为四个部分：

- 基础镜像(父镜像)信息指令 FROM
- 维护者信息指令 MAINTAINER
- 镜像操作指令 RUN 、 EVN 、 ADD 和 WORKDIR 等
- 容器启动指令 CMD 、 ENTRYPOINT 和 USER 等

### Dockerfile文件格式

下面是一段简单的Dockerfile的例子：

``` dockerfile
FROM python:2.7
MAINTAINER QYMUA <qymuao3o@gmail.com>
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["app.py"]
```
1. 从 Docker Hub 上 pull 下 python 2.7 的基础镜像
2. 显示维护者的信息
3. `copy` 当前目录到容器中的 `/app` 目录下 复制本地主机的 `<src>` ( `Dockerfile` 所在目录的相对路径)到容器里 `<dest>`
4. 指定工作路径为 `/app`
5. 安装依赖包
6. 暴露 `5000` 端口
7. 启动 `app`

这个例子是启动一个 `python flask app` 的 `Dockerfile` ( `flask` 是 `python` 的一个轻量的 web 框架)，相信大家从这个例子中能够稍微理解了Dockfile的组成以及指令的编写过程。

### 构建镜像

docker build 命令会根据 Dockerfile 文件及上下文构建新 Docker 镜像。构建上下文是指 Dockerfile 所在的`本地路径`或一个`URL（Git仓库地址）`。构建上下文环境会被递归处理，所以构建所指定的路径还包括了子目录，而URL还包括了其中指定的子模块。

将当前目录做为构建上下文时，可以像下面这样使用docker build命令构建镜像：

``` mipsasm
docker build .
Sending build context to Docker daemon  6.51 MB
...
```

说明：构建会在 Docker 后台守护进程（daemon）中执行，而不是CLI中。构建前，构建进程会将全部内容（递归）发送到守护进程。大多情况下，应该将一个空目录作为构建上下文环境，并将 Dockerfile 文件放在该目录下。

在构建上下文中使用的 Dockerfile 文件，是一个构建指令文件。为了提高构建性能，可以通过`.dockerignore`文件排除上下文目录下不需要的文件和目录。

在 Docker 构建镜像的第一步，docker CLI 会先在上下文目录中寻找`.dockerignore`文件，根据`.dockerignore` 文件排除上下文目录中的部分文件和目录，然后把剩下的文件和目录传递给 Docker 服务。

Dockerfile 一般位于构建上下文的根目录下，也可以通过-f指定该文件的位置：

``` n1ql
docker build -f /path/to/a/Dockerfile .
```
构建时，还可以通过-t参数指定构建成镜像的仓库、标签。

### 镜像标签

``` armasm
docker build -t nginx/v3 .
```

如果存在多个仓库下，或使用多个镜像标签，就可以使用多个-t参数：

``` armasm
docker build -t nginx/v3:1.0.2 -t nginx/v3:latest .
```

在 Docker 守护进程执行 Dockerfile 中的指令前，首先会对 Dockerfile 进行语法检查，有语法错误时会返回：

``` subunit
docker build -t nginx/v3 .
Sending build context to Docker daemon 2.048 kB
Error response from daemon: Unknown instruction: RUNCMD
```
**其它 docker build 的用法**

`直接用 Git repo 进行构建`

``` vim
$ docker build https://github.com/twang2218/gitlab-ce-zh.git#:11.1

Sending build context to Docker daemon 2.048 kB
Step 1 : FROM gitlab/gitlab-ce:11.1.0-ce.0
11.1.0-ce.0: Pulling from gitlab/gitlab-ce
aed15891ba52: Already exists
773ae8583d14: Already exists
...
```
这行命令指定了构建所需的 Git repo，并且指定默认的 master 分支，构建目录为 `/11.1/`，然后 Docker 就会自己去 git clone 这个项目、切换到指定分支、并进入到指定目录后开始构建。

`用给定的 tar 压缩包构建`

``` gams
$ docker build http://server/context.tar.gz
```
如果所给出的 URL 不是个 Git repo，而是个 `tar` 压缩包，那么 Docker 引擎会下载这个包，并自动解压缩，以其作为上下文，开始构建。

`从标准输入中读取 Dockerfile 进行构建`

``` n1ql
docker build - < Dockerfile or cat Dockerfile | docker build -
```

如果标准输入传入的是文本文件，则将其视为 Dockerfile，并开始构建。这种形式由于直接从标准输入中读取 `Dockerfile` 的内容，它没有上下文，因此不可以像其他方法那样可以将本地文件 `COPY` 进镜像之类的事情。

`从标准输入中读取上下文压缩包进行构建`

``` stylus
$ docker build - < context.tar.gz
```

如果发现标准输入的文件格式是 `gzip`、`bzip2` 以及 `xz` 的话，将会使其为上下文压缩包，直接将其展开，将里面视为上下文，并开始构建。

### 缓存

Docker 守护进程会一条一条的执行 Dockerfile 中的指令，而且会在每一步提交并生成一个新镜像，最后会输出最终镜像的ID。生成完成后，Docker 守护进程会自动清理你发送的上下文。 Dockerfile文件中的每条指令会被独立执行，并会创建一个新镜像，`RUN cd /tmp`等命令不会对下条指令产生影响。 Docker 会重用已生成的中间镜像，以加速docker build的构建速度。以下是一个使用了缓存镜像的执行过程：

``` shell
$ docker build -t svendowideit/ambassador .
Sending build context to Docker daemon 15.36 kB
Step 1/4 : FROM alpine:3.2
 ---> 31f630c65071
Step 2/4 : MAINTAINER SvenDowideit@home.org.au
 ---> Using cache
 ---> 2a1c91448f5f
Step 3/4 : RUN apk update &&      apk add socat &&        rm -r /var/cache/
 ---> Using cache
 ---> 21ed6e7fbb73
Step 4/4 : CMD env | grep _TCP= | (sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat -t 100000000 TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/' && echo wait) | sh
 ---> Using cache
 ---> 7ea8aef582cc
Successfully built 7ea8aef582cc
```
构建缓存仅会使用本地父生成链上的镜像，如果不想使用本地缓存的镜像，也可以通过`--cache-from`指定缓存。指定后将不再使用本地生成的镜像链，而是从镜像仓库中下载。

### 寻找缓存的逻辑

Docker 寻找缓存的逻辑其实就是树型结构根据 Dockerfile 指令遍历子节点的过程。下图可以说明这个逻辑。

``` 
 FROM base_image:version           Dockerfile:
           +----------+                FROM base_image:version
           |base image|                RUN cmd1  --> use cache because we found base image
           +-----X----+                RUN cmd11 --> use cache because we found cmd1
                / \
               /   \
       RUN cmd1     RUN cmd2           Dockerfile:
       +------+     +------+           FROM base_image:version
       |image1|     |image2|           RUN cmd2  --> use cache because we found base image
       +---X--+     +------+           RUN cmd21 --> not use cache because there's no child node
          / \                                        running cmd21, so we build a new image here
         /   \
RUN cmd11     RUN cmd12
+-------+     +-------+
|image11|     |image12|
+-------+     +-------+
```

大部分指令可以根据上述逻辑去寻找缓存，除了 ADD 和 COPY 。这两个指令会复制文件内容到镜像内，除了指令相同以外，Docker 还会检查每个文件内容校验(不包括最后修改时间和最后访问时间)，如果校验不一致，则不会使用缓存。

除了这两个命令，Docker 并不会去检查容器内的文件内容，比如 `RUN apt-get -y update`，每次执行时文件可能都不一样，但是 Docker 认为命令一致，会继续使用缓存。这样一来，以后构建时都不会再重新运行apt-get -y update。

如果 Docker 没有找到当前指令的缓存，则会构建一个新的镜像，并且之后的所有指令都不会再去寻找缓存。

### 修改容器内容

容器启动后，需要对容器内的文件进行进一步的完善，可以使用docker exec -it xx bash命令再次进行修改，以上面的示例为基础，修改 nginx 启动页面内容：

``` elixir
docker exec -it docker_nginx_v1   bash
root@3729b97e8226:/# echo '<h1>Hello, Docker neo!</h1>' > /usr/share/nginx/html/index.html
root@3729b97e8226:/# exit
exit
```
以交互式终端方式进入 docker_nginx_v1 容器，并执行了 bash 命令，也就是获得一个可操作的 Shell。

修改了容器的文件，也就是改动了容器的存储层，可以通过 docker diff 命令看到具体的改动

``` r
docker diff docker_nginx_v1 
... 
```

### Dockerfile常用指令

根据上面的例子，我们已经差不多知道了Dockerfile的组成以及指令的编写过程，我们再来理解一下这些常用命令就会得心应手了。

由于 `Dockerfile` 中所有的命令都是以下格式：`INSTRUCTION argument` ，指令 `(INSTRUCTION)` 不分大小写，但是推荐大写，和sql语句是不是很相似呢？下面我们正式来讲解一下这些指令集吧。

**FROM**

`FROM` 是用于指定基础的 `images` ，一般格式为 `FROM <image>` or `FORM <image>:<tag>` ，所有的 `Dockerfile` 都用该以 `FROM` 开头，`FROM` 命令指明 `Dockerfile` 所创建的镜像文件以什么镜像为基础，`FROM` 以后的所有指令都会在 `FROM` 的基础上进行创建镜像。可以在同一个 `Dockerfile` 中多次使用 `FROM` 命令用于创建多个镜像。比如我们要指定 `python 2.7` 的基础镜像，我们可以像如下写法一样：

``` ruleslanguage
FROM python:2.7
```
**MAINTAINER**

MAINTAINER 是用于指定镜像创建者和联系方式，一般格式为 `MAINTAINER <name>` 。这里我设置成我的 ID 和邮箱：

``` css
MAINTAINER QYMUA <qymuao3o@gmail.com>
```

**COPY**

COPY 是用于复制本地主机的 `<src>` (为 Dockerfile 所在目录的相对路径)到容器中的 `<dest>`。

当使用本地目录为源目录时，推荐使用 COPY 。一般格式为 `COPY <src><dest>` 。例如我们要拷贝当前目录到容器中的 /app 目录下，我们可以这样操作：

``` 
COPY . /app
```
和 RUN 指令一样，也有两种格式，一种类似于命令行，一种类似于函数调用=>`COPY [--chown=<user>:<group>] ["<源路径1>",... "<目标路径>"]`

**ADD(更高级的复制文件)**

ADD 指令和 COPY 的格式和性质基本一致。但是在 COPY 基础上增加了一些功能。

比如 `<源路径>` 可以是一个 URL，这种情况下，Docker 引擎会试图去下载这个链接的文件放到 <目标路径> 去。下载后的文件权限自动设置为 600，如果这并不是想要的权限，那么还需要增加额外的一层 RUN 进行权限调整，另外，如果下载的是个压缩包，需要解压缩，也一样还需要额外的一层 RUN 指令进行解压缩。所以不如直接使用 RUN 指令，然后使用 wget 或者 curl 工具下载，处理权限、解压缩、然后清理无用文件更合理。因此，这个功能其实并不实用，而且不推荐使用。

另外需要注意的是，ADD 指令会令镜像构建缓存失效，从而可能会令镜像构建变得比较缓慢。

因此在 COPY 和 ADD 指令中选择的时候，可以遵循这样的原则，所有的文件复制均使用 COPY 指令，仅在需要自动解压缩的场合使用 ADD。

**WORKDIR**

WORKDIR 用于配合 RUN，CMD，ENTRYPOINT 命令设置当前工作路径。可以设置多次，如果是相对路径，则相对前一个 WORKDIR 命令。默认路径为/。一般格式为 `WORKDIR /path/to/work/dir` 。例如我们设置/app 路径，我们可以进行如下操作：

``` dockerfile
WORKDIR /app
```

**RUN**

`RUN` 用于容器内部执行命令。每个 `RUN` 命令相当于在原有的镜像基础上添加了一个改动层，原有的镜像不会有变化。shell格式为 `RUN <command>` 。例如我们要安装 python 依赖包，我们做法如下：

``` dockerfile
RUN pip install -r requirements.txt
```
exec 格式：`RUN ["可执行文件", "参数1", "参数2"]`，这更像是函数调用中的格式。

Dockerfile 中每一个指令都会建立一层，RUN 也不例外。每一个 RUN 的行为，就和刚才我们手工建立镜像的过程一样：新建立一层，在其上执行这些命令，执行结束后，commit 这一层的修改，构成新的镜像。


**EXPOSE**

EXPOSE 命令用来指定对外开放的端口。一般格式为 `EXPOSE <port> [<port>...]`

例如上面那个例子，开放5000端口：

``` lsl
EXPOSE 5000
```

**ENTRYPOINT**

ENTRYPOINT 可以让你的容器表现得像一个可执行程序一样。一个 Dockerfile 中只能有一个 ENTRYPOINT，如果有多个，则最后一个生效。

ENTRYPOINT 命令也有两种格式：

- ENTRYPOINT ["executable", "param1", "param2"] ：推荐使用的 exec形式
- ENTRYPOINT command param1 param2 ：shell 形式

例如下面这个，我们要将 python 镜像变成可执行的程序，我们可以这样去做：

``` dockerfile
ENTRYPOINT ["python"]
```
**CMD**

CMD 命令用于启动容器时默认执行的命令，CMD 命令可以包含可执行文件，也可以不包含可执行文件。不包含可执行文件的情况下就要用 ENTRYPOINT 指定一个，然后 CMD 命令的参数就会作为ENTRYPOINT的参数。

CMD 命令有三种格式：

- CMD ["executable","param1","param2"]：推荐使用的 exec 形式。
- CMD ["param1","param2"]：无可执行程序形式
- CMD command param1 param2：shell 形式。

一个 Dockerfile 中只能有一个CMD，如果有多个，则最后一个生效。而 CMD 的 shell 形式默认调用 /bin/sh -c 执行命令。

CMD 命令会被 Docker 命令行传入的参数覆盖：`docker run busybox /bin/echo Hello` Docker 会把 CMD 里的命令覆盖。

例如我们要启动 `/app` ，我们可以用如下命令实现：

``` dockerfile
CMD ["app.py"]
```

## Docker三剑客之Compose项目

### 了解docker三剑客

**docker-machine是解决docker运行环境问题**。

docker技术是基于Linux内核的cgroup技术实现的，那么问题来了，如果在非Linux平台上使用docker技术需要依赖安装Linux系统的虚拟机。docker-machine就是docker公司官方提出的，用于在各种平台上快速创建具有docker服务的虚拟机的技术。你可以把它理解为virtualbox或者vmware，最开始在win7上用得比较多，但是win10开始自带了hyper-v虚拟机，已经不再需要docker-machine了，docker可以直接运行在安装了Linux系统得hyper-v上。

**dcoker-compose主要是解决本地docker容器编排问题。**

一般是通过YAML配置文件来使用它，这个YAML文件里能记录多个容器启动的配置信息（镜像、启动命令、端口映射等），最后只需要执行docker-compose对应的命令就会像执行脚本一样地批量创建和销毁容器。

**docker-swarmdocker-swarm是解决多主机多个容器调度部署得问题。**

swarm是基于docker平台实现的集群技术，他可以通过几条简单的指令快速的创建一个docker集群，接着在集群的共享网络上部署应用，最终实现分布式的服务。swarm技术相当不成熟，很多配置功能都无法实现，只能说是个半成品，目前更多的是使用Kubernetes来管理集群和调度容器。

### dockerfile与docker-compose的区别

简单总结：

1. dockerfile: 构建镜像；
2. docker run: 启动容器；
3. docker-compose: 启动服务；

简而言之， Dockerfile 可以让用户管理一个单独的应用容器；而 Compose 则允许用户在一个单独的docker-compose.yml模板文件（YAML 格式）中定义一组相关联的应用容器（被称为一个 project，即项目），例如一个 Web 服务容器再加上后端的数据库服务容器等。

### Docker Compose 介绍

Docker-Compose 是 Docker 的一种编排服务，是一个用于在 Docker 上定义并运行复杂应用的工具，可以让用户在集群中部署分布式应用。

通过 Docker-Compose 用户可以很容易地用一个配置文件定义一个多容器的应用，然后使用一条指令安装这个应用的所有依赖，完成构建。Docker-Compose 解决了容器与容器之间如何管理编排的问题。

Docker Compose 工作原理图

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849280.png)

Compose 中有两个重要的概念：

- 服务 (service) ：一个应用的容器，实际上可以包括若干运行相同镜像的容器实例。
- 项目 (project) ：由一组关联的应用容器组成的一个完整业务单元，在 docker-compose.yml 文件中定义。

一个项目可以由多个服务（容器）关联而成，Compose 面向项目进行管理，通过子命令对项目中的一组容器进行便捷地生命周期管理。

Compose 项目由 Python 编写，实现上调用了 Docker 服务提供的 API 来对容器进行管理。因此，只要所操作的平台支持 Docker API，就可以在其上利用 Compose 来进行编排管理。

### 安装与卸载

`Compose` 支持 Linux、macOS、Windows 10 三大平台。

`Compose` 可以通过 Python 的包管理工具 `pip` 进行安装，也可以直接下载编译好的二进制文件使用，甚至能够直接在 Docker 容器中运行。

前两种方式是传统方式，适合本地环境下安装使用；最后一种方式则不破坏系统环境，更适合云计算场景。

`Docker for Mac` 、`Docker for Windows` 自带 `docker-compose` 二进制文件，安装 Docker 之后可以直接使用。

``` lsl
# docker-compose --version
docker-compose version 1.24.1, build 4667896b
```
**二进制包**

在 Linux 上的也安装十分简单，从 官方 GitHub Release 处直接下载编译好的二进制文件即可。

例如，在 Linux 64 位系统上直接下载对应的二进制包。

``` ruby
$ sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```
通常也可以通过apt-get包管理安装docker-compose 不同的发行版本不一样，具体请参考官方文档

**卸载**

如果是二进制包方式安装的，删除二进制文件即可。

``` shell
$ sudo rm /usr/local/bin/docker-compose
```

如果是通过 pip 安装的，则执行如下命令即可删除。

``` shell
$ sudo pip uninstall docker-compose
```
### 使用

**术语**

首先介绍几个术语。

- 服务 (service)：一个应用容器，实际上可以运行多个相同镜像的实例。

- 项目 (project)：由一组关联的应用容器组成的一个完整业务单元。

可见，一个项目可以由多个服务（容器）关联而成，Compose 面向项目进行管理。

**场景**

最常见的项目是 web 网站，该项目应该包含 web 应用和缓存。

下面我们用 Python 来建立一个能够记录页面访问次数的 web 网站。

**web 应用**

新建文件夹，在该目录中编写 app.py 文件

``` python
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return 'Hello World! 该页面已被访问 {} 次。\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```

**Dockerfile**

编写 Dockerfile 文件，内容为

``` dockerfile
FROM python:3.6-alpine
ADD . /code
WORKDIR /code
RUN pip install redis flask
CMD ["python", "app.py"]
```

**docker-compose.yml**

编写 docker-compose.yml 文件，这个是 Compose 使用的主模板文件。

``` dts
version: '3'
services:

  web:
    build: .
    ports:
     - "5000:5000"

  redis:
    image: "redis:alpine"
```

**运行 compose 项目**

``` shell
$ docker-compose up
```
![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849539.png)

此时访问本地 5000 端口，每次刷新页面，计数就会加 1。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472849511.png)

### 命令说明

**命令对象与格式**

对于 Compose 来说，大部分命令的对象既可以是项目本身，也可以指定为项目中的服务或者容器。如果没有特别的说明，命令对象将是项目，这意味着项目中所有的服务都会受到命令影响。

执行 `docker-compose [COMMAND] --help` 或者 `docker-compose help [COMMAND]` 可以查看具体某个命令的使用格式。

docker-compose 命令的基本的使用格式是

``` inform7
docker-compose [-f=<arg>...] [options] [COMMAND] [ARGS...]
```
**命令选项**

- `-f, --file FILE` 指定使用的 Compose 模板文件，默认为 docker-compose.yml，可以多次指定。

- `-p, --project-name NAME` 指定项目名称，默认将使用所在目录名称作为项目名。

- `--x-networking` 使用 Docker 的可拔插网络后端特性

- `--x-network-driver DRIVER` 指定网络后端的驱动，默认为 bridge

- `--verbose` 输出更多调试信息。

- `-v, --version` 打印版本并退出。

**命令使用说明**

`build`
格式为 `docker-compose build [options] [SERVICE...]。`

构建（重新构建）项目中的服务容器。

服务容器一旦构建后，将会带上一个标记名，例如对于 web 项目中的一个 db 容器，可能是 web_db。

可以随时在项目目录下运行 docker-compose build 来重新构建服务。

选项包括：

选项包括：

- --force-rm 删除构建过程中的临时容器。

- --no-cache 构建镜像过程中不使用 cache（这将加长构建过程）。

- --pull 始终尝试通过 pull 来获取更新版本的镜像。

**config**

验证 Compose 文件格式是否正确，若正确则显示配置，若格式错误显示错误原因

**down**

此命令将会停止 up 命令所启动的容器，并移除网络

**exec**

进入指定的容器。

**help**

获得一个命令的帮助。

**images**

列出 Compose 文件中包含的镜像。

**kill**

格式为 `docker-compose kill [options] [SERVICE...]`。

通过发送 SIGKILL 信号来强制停止服务容器。

支持通过 -s 参数来指定发送的信号，例如通过如下指令发送 SIGINT 信号。

``` shell
$ docker-compose kill -s SIGINT
```

**logs**

格式为 `docker-compose logs [options] [SERVICE...]`。

查看服务容器的输出。默认情况下，docker-compose 将对不同的服务输出使用不同的颜色来区分。可以通过 `--no-color` 来关闭颜色。

该命令在调试问题的时候十分有用。

**pause**

格式为 `docker-compose pause [SERVICE...]`。

暂停一个服务容器。

**port**

格式为 `docker-compose port [options] SERVICE PRIVATE_PORT`。

打印某个容器端口所映射的公共端口。

选项：

- --protocol=proto 指定端口协议，tcp（默认值）或者 udp。

- --index=index 如果同一服务存在多个容器，指定命令对象容器的序号（默认为 1）。

**ps**

格式为 `docker-compose ps [options] [SERVICE...]`。

列出项目中目前的所有容器。

选项：

- -q 只打印容器的 ID 信息。

**pull**

格式为 `docker-compose pull [options] [SERVICE...]`。

拉取服务依赖的镜像。

选项：

- --ignore-pull-failures 忽略拉取镜像过程中的错误。

**push**

推送服务依赖的镜像到 Docker 镜像仓库。

**restart**

格式为 `docker-compose restart [options] [SERVICE...]`。

重启项目中的服务。

选项：

- -t, --timeout TIMEOUT 指定重启前停止容器的超时（默认为 10 秒）。

**rm**
格式为 `docker-compose rm [options] [SERVICE...]`。

删除所有（停止状态的）服务容器。推荐先执行 `docker-compose stop` 命令来停止容器。

选项：

- -f, --force 强制直接删除，包括非停止状态的容器。一般尽量不要使用该选项。

- -v 删除容器所挂载的数据卷。

**run**

格式为 `docker-compose run [options] [-p PORT...] [-e KEY=VAL...] SERVICE [COMMAND] [ARGS...]`。

在指定服务上执行一个命令。

例如：

``` autoit
$ docker-compose run ubuntu ping docker.com
```

将会启动一个 ubuntu 服务容器，并执行 ping docker.com 命令。

默认情况下，如果存在关联，则所有关联的服务将会自动被启动，除非这些服务已经在运行中。

该命令类似启动容器后运行指定的命令，相关卷、链接等等都将会按照配置自动创建。

两个不同点：

给定命令将会覆盖原有的自动运行命令；

不会自动创建端口，以避免冲突。

如果不希望自动启动关联的容器，可以使用 `--no-deps` 选项，例如

``` vim
$ docker-compose run --no-deps web python manage.py shell
```

将不会启动 web 容器所关联的其它容器。

选项：

``` haml
-d 后台运行容器。

--name NAME 为容器指定一个名字。

--entrypoint CMD 覆盖默认的容器启动指令。

-e KEY=VAL 设置环境变量值，可多次使用选项来设置多个环境变量。

-u, --user="" 指定运行容器的用户名或者 uid。

--no-deps 不自动启动关联的服务容器。

--rm 运行命令后自动删除容器，d 模式下将忽略。

-p, --publish=[] 映射容器端口到本地主机。

--service-ports 配置服务端口并映射到本地主机。

-T 不分配伪 tty，意味着依赖 tty 的指令将无法运行。
```

**scale**

格式为 `docker-compose scale [options] [SERVICE=NUM...]`。

设置指定服务运行的容器个数。

通过 service=num 的参数来设置数量。例如：

``` lsl
$ docker-compose scale web=3 db=2
```

将启动 3 个容器运行 web 服务，2 个容器运行 db 服务。

一般的，当指定数目多于该服务当前实际运行容器，将新创建并启动容器；反之，将停止容器。

选项：

- -t, --timeout TIMEOUT 停止容器时候的超时（默认为 10 秒）。

**start**

格式为 `docker-compose start [SERVICE...]`。

启动已经存在的服务容器。

**stop**

格式为 `docker-compose stop [options] [SERVICE...]`。

停止已经处于运行状态的容器，但不删除它。通过 docker-compose start 可以再次启动这些容器。

选项：

- -t, --timeout TIMEOUT 停止容器时候的超时（默认为 10 秒）。

**top**

查看各个服务容器内运行的进程。

**unpause**

格式为 `docker-compose unpause [SERVICE...]`。

恢复处于暂停状态中的服务。

**up**

格式为 `docker-compose up [options] [SERVICE...]`。

该命令十分强大，它将尝试自动完成包括构建镜像，（重新）创建服务，启动服务，并关联服务相关容器的一系列操作。

链接的服务都将会被自动启动，除非已经处于运行状态。

可以说，大部分时候都可以直接通过该命令来启动一个项目。

默认情况，docker-compose up 启动的容器都在前台，控制台将会同时打印所有容器的输出信息，可以很方便进行调试。

当通过 Ctrl-C 停止命令时，所有容器将会停止。

如果使用 `docker-compose up -d`，将会在后台启动并运行所有的容器。一般推荐生产环境下使用该选项。

默认情况，如果服务容器已经存在，docker-compose up 将会尝试停止容器，然后重新创建（保持使用 volumes-from 挂载的卷），以保证新启动的服务匹配 docker-compose.yml 文件的最新内容。如果用户不希望容器被停止并重新创建，可以使用 docker-compose up --no-recreate。这样将只会启动处于停止状态的容器，而忽略已经运行的服务。如果用户只想重新部署某个服务，可以使用 docker-compose up --no-deps -d <SERVICE_NAME> 来重新创建服务并后台停止旧服务，启动新服务，并不会影响到其所依赖的服务。

选项：

``` haml
-d 在后台运行服务容器。

--no-color 不使用颜色来区分不同的服务的控制台输出。

--no-deps 不启动服务所链接的容器。

--force-recreate 强制重新创建容器，不能与 --no-recreate 同时使用。

--no-recreate 如果容器已经存在了，则不重新创建，不能与 --force-recreate 同时使用。

--no-build 不自动构建缺失的服务镜像。

-t, --timeout TIMEOUT 停止容器时候的超时（默认为 10 秒）。
```

**version**

格式为 `docker-compose version`。

打印版本信息。

### Compose模板文件

模板文件是使用 `Compose` 的核心，涉及到的指令关键字也比较多。但大家不用担心，这里面大部分指令跟 `docker run` 相关参数的含义都是类似的。

默认的模板文件名称为 `docker-compose.yml`，格式为 YAML 格式。

```yaml
version: "3"

services:
  webapp:
    image: examples/web
    ports:
      - "80:80"
    volumes:
      - "/data"
```

注意每个服务都必须通过 `image` 指令指定镜像或 `build` 指令（需要 Dockerfile）等来自动构建生成镜像。

如果使用 `build` 指令，在 `Dockerfile` 中设置的选项(例如：`CMD`, `EXPOSE`, `VOLUME`, `ENV` 等) 将会自动被获取，无需在 `docker-compose.yml` 中再次设置。

下面分别介绍各个指令的用法。

`build`

指定 `Dockerfile` 所在文件夹的路径（可以是绝对路径，或者相对 docker-compose.yml 文件的路径）。 `Compose` 将会利用它自动构建这个镜像，然后使用这个镜像。

```yaml
version: '3'
services:

  webapp:
    build: ./dir
```

你也可以使用 `context` 指令指定 `Dockerfile` 所在文件夹的路径。

使用 `dockerfile` 指令指定 `Dockerfile` 文件名。

使用 `arg` 指令指定构建镜像时的变量。

```yaml
version: '3'
services:

  webapp:
    build:
      context: ./dir
      dockerfile: Dockerfile-alternate
      args:
        buildno: 1
```

使用 `cache_from` 指定构建镜像的缓存

```yaml
build:
  context: .
  cache_from:
    - alpine:latest
    - corp/web_app:3.14
```

`cap_add, cap_drop`

指定容器的内核能力（capacity）分配。

例如，让容器拥有所有能力可以指定为：

```yaml
cap_add:
  - ALL
```

去掉 NET_ADMIN 能力可以指定为：

```yaml
cap_drop:
  - NET_ADMIN
```

`command`

覆盖容器启动后默认执行的命令。

```yaml
command: echo "hello world"
```

`configs`

仅用于 `Swarm mode`，详细内容请查看 [`Swarm mode`](../swarm_mode/) 一节。

`cgroup_parent`

指定父 `cgroup` 组，意味着将继承该组的资源限制。

例如，创建了一个 cgroup 组名称为 `cgroups_1`。

```yaml
cgroup_parent: cgroups_1
```

`container_name`

指定容器名称。默认将会使用 `项目名称_服务名称_序号` 这样的格式。

```yaml
container_name: docker-web-container
```

>注意: 指定容器名称后，该服务将无法进行扩展（scale），因为 Docker 不允许多个容器具有相同的名称。

`deploy`

仅用于 `Swarm mode`，详细内容请查看 [`Swarm mode`](../swarm_mode/) 一节

`devices`

指定设备映射关系。

```yaml
devices:
  - "/dev/ttyUSB1:/dev/ttyUSB0"
```

`depends_on`

解决容器的依赖、启动先后的问题。以下例子中会先启动 `redis` `db` 再启动 `web`

```yaml
version: '3'

services:
  web:
    build: .
    depends_on:
      - db
      - redis

  redis:
    image: redis

  db:
    image: postgres
```

>注意：`web` 服务不会等待 `redis` `db` 「完全启动」之后才启动。

`dns`

自定义 `DNS` 服务器。可以是一个值，也可以是一个列表。

```yaml
dns: 8.8.8.8

dns:
  - 8.8.8.8
  - 114.114.114.114
```

`dns_search`

配置 `DNS` 搜索域。可以是一个值，也可以是一个列表。

```yaml
dns_search: example.com

dns_search:
  - domain1.example.com
  - domain2.example.com
```

`tmpfs`

挂载一个 tmpfs 文件系统到容器。

```yaml
tmpfs: /run
tmpfs:
  - /run
  - /tmp
```

`env_file`

从文件中获取环境变量，可以为单独的文件路径或列表。

如果通过 `docker-compose -f FILE` 方式来指定 Compose 模板文件，则 `env_file` 中变量的路径会基于模板文件路径。

如果有变量名称与 `environment` 指令冲突，则按照惯例，以后者为准。

```bash
env_file: .env

env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/secrets.env
```

环境变量文件中每一行必须符合格式，支持 `#` 开头的注释行。

```bash
# common.env: Set development environment
PROG_ENV=development
```

`environment`

设置环境变量。你可以使用数组或字典两种格式。

只给定名称的变量会自动获取运行 Compose 主机上对应变量的值，可以用来防止泄露不必要的数据。

```yaml
environment:
  RACK_ENV: development
  SESSION_SECRET:

environment:
  - RACK_ENV=development
  - SESSION_SECRET
```

如果变量名称或者值中用到 `true|false，yes|no` 等表达 [布尔](https://yaml.org/type/bool.html) 含义的词汇，最好放到引号里，避免 YAML 自动解析某些内容为对应的布尔语义。这些特定词汇，包括

```bash
y|Y|yes|Yes|YES|n|N|no|No|NO|true|True|TRUE|false|False|FALSE|on|On|ON|off|Off|OFF
```

`expose`

暴露端口，但不映射到宿主机，只被连接的服务访问。

仅可以指定内部端口为参数

```yaml
expose:
 - "3000"
 - "8000"
```

`external_links`

>注意：不建议使用该指令。

链接到 `docker-compose.yml` 外部的容器，甚至并非 `Compose` 管理的外部容器。

```yaml
external_links:
 - redis_1
 - project_db_1:mysql
 - project_db_1:postgresql
```

`extra_hosts`

类似 Docker 中的 `--add-host` 参数，指定额外的 host 名称映射信息。

```yaml
extra_hosts:
 - "googledns:8.8.8.8"
 - "dockerhub:52.1.157.61"
```

会在启动后的服务容器中 `/etc/hosts` 文件中添加如下两条条目。

```bash
8.8.8.8 googledns
52.1.157.61 dockerhub
```

`healthcheck`

通过命令检查容器是否健康运行。

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 1m30s
  timeout: 10s
  retries: 3
```

`image`

指定为镜像名称或镜像 ID。如果镜像在本地不存在，`Compose` 将会尝试拉取这个镜像。

```yaml
image: ubuntu
image: orchardup/postgresql
image: a4bc65fd
```

`labels`

为容器添加 Docker 元数据（metadata）信息。例如可以为容器添加辅助说明信息。

```yaml
labels:
  com.startupteam.description: "webapp for a startup team"
  com.startupteam.department: "devops department"
  com.startupteam.release: "rc3 for v1.0"
```

`links`

>注意：不推荐使用该指令。

`logging`

配置日志选项。

```yaml
logging:
  driver: syslog
  options:
    syslog-address: "tcp://192.168.0.42:123"
```

目前支持三种日志驱动类型。

```yaml
driver: "json-file"
driver: "syslog"
driver: "none"
```

`options` 配置日志驱动的相关参数。

```yaml
options:
  max-size: "200k"
  max-file: "10"
```

`network_mode`

设置网络模式。使用和 `docker run` 的 `--network` 参数一样的值。

```yaml
network_mode: "bridge"
network_mode: "host"
network_mode: "none"
network_mode: "service:[service name]"
network_mode: "container:[container name/id]"
```

`networks`

配置容器连接的网络。

```yaml
version: "3"
services:

  some-service:
    networks:
     - some-network
     - other-network

networks:
  some-network:
  other-network:
```

`pid`

跟主机系统共享进程命名空间。打开该选项的容器之间，以及容器和宿主机系统之间可以通过进程 ID 来相互访问和操作。

```yaml
pid: "host"
```

`ports`

暴露端口信息。

使用宿主端口：容器端口 `(HOST:CONTAINER)` 格式，或者仅仅指定容器的端口（宿主将会随机选择端口）都可以。

```yaml
ports:
 - "3000"
 - "8000:8000"
 - "49100:22"
 - "127.0.0.1:8001:8001"
```

*注意：当使用 `HOST:CONTAINER` 格式来映射端口时，如果你使用的容器端口小于 60 并且没放到引号里，可能会得到错误结果，因为 `YAML` 会自动解析 `xx:yy` 这种数字格式为 60 进制。为避免出现这种问题，建议数字串都采用引号包括起来的字符串格式。*

`secrets`

存储敏感数据，例如 `mysql` 服务密码。

```yaml
version: "3.1"
services:

mysql:
  image: mysql
  environment:
    MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
  secrets:
    - db_root_password
    - my_other_secret

secrets:
  my_secret:
    file: ./my_secret.txt
  my_other_secret:
    external: true
```

`security_opt`

指定容器模板标签（label）机制的默认属性（用户、角色、类型、级别等）。例如配置标签的用户名和角色名。

```yaml
security_opt:
    - label:user:USER
    - label:role:ROLE
```

`stop_signal`

设置另一个信号来停止容器。在默认情况下使用的是 SIGTERM 停止容器。

```yaml
stop_signal: SIGUSR1
```

`sysctls`

配置容器内核参数。

```yaml
sysctls:
  net.core.somaxconn: 1024
  net.ipv4.tcp_syncookies: 0

sysctls:
  - net.core.somaxconn=1024
  - net.ipv4.tcp_syncookies=0
```

`ulimits`

指定容器的 ulimits 限制值。

例如，指定最大进程数为 65535，指定文件句柄数为 20000（软限制，应用可以随时修改，不能超过硬限制） 和 40000（系统硬限制，只能 root 用户提高）。

```yaml
  ulimits:
    nproc: 65535
    nofile:
      soft: 20000
      hard: 40000
```

`volumes`

数据卷所挂载路径设置。可以设置宿主机路径 （`HOST:CONTAINER`） 或加上访问模式 （`HOST:CONTAINER:ro`）。

该指令中路径支持相对路径。

```yaml
volumes:
 - /var/lib/mysql
 - cache/:/tmp/cache
 - ~/configs:/etc/configs/:ro
```

**其它指令**

此外，还有包括 `domainname, entrypoint, hostname, ipc, mac_address, privileged, read_only, shm_size, restart, stdin_open, tty, user, working_dir` 等指令，基本跟 `docker run` 中对应参数的功能一致。

指定服务容器启动后执行的入口文件。

```yaml
entrypoint: /code/entrypoint.sh
```

指定容器中运行应用的用户名。

```yaml
user: nginx
```

指定容器中工作目录。

```yaml
working_dir: /code
```

指定容器中搜索域名、主机名、mac 地址等。

```yaml
domainname: your_website.com
hostname: test
mac_address: 08-00-27-00-0C-0A
```

允许容器中运行一些特权命令。

```yaml
privileged: true
```

指定容器退出后的重启策略为始终重启。该命令对保持服务始终运行十分有效，在生产环境中推荐配置为 `always` 或者 `unless-stopped`。

```yaml
restart: always
```

以只读模式挂载容器的 root 文件系统，意味着不能对容器内容进行修改。

```yaml
read_only: true
```

打开标准输入，可以接受外部输入。

```yaml
stdin_open: true
```

模拟一个伪终端。

```yaml
tty: true
```

**读取变量**

Compose 模板文件支持动态读取主机的系统环境变量和当前目录下的 `.env` 文件中的变量。

例如，下面的 Compose 文件将从运行它的环境中读取变量 `${MONGO_VERSION}` 的值，并写入执行的指令中。

```yaml
version: "3"
services:

db:
  image: "mongo:${MONGO_VERSION}"
```

如果执行 `MONGO_VERSION=3.2 docker-compose up` 则会启动一个 `mongo:3.2` 镜像的容器；如果执行 `MONGO_VERSION=2.8 docker-compose up` 则会启动一个 `mongo:2.8` 镜像的容器。

若当前目录存在 `.env` 文件，执行 `docker-compose` 命令时将从该文件中读取变量。

在当前目录新建 `.env` 文件并写入以下内容。

```bash
# 支持 # 号注释
MONGO_VERSION=3.6
```

执行 `docker-compose up` 则会启动一个 `mongo:3.6` 镜像的容器。

# Docker for CTF Apply 

---

### CTF-web

1、查找可用镜像：docker search lamp(这是linux+apache+mysql+php的集成环境，部署web题可用)

2、拉取镜像：docker pull tutum/lamp （具体镜像看需求，这里是Out-of-the-box LAMP image (PHP+MySQL) ）

3、运行镜像并绑定端口：docker run -d -p 1000:80 tutum/lamp 1000指的是需要公网访问的端口，后面跟镜像名称，如果是要不同端口搭建不同web题目可重复使用此命令，改端口就行。

4、最好先把题目下载到服务器本地，然后把题目拷贝到docker容器：docker cp 题目名称 容器ID:/var/www/html 一般web路径是/var/www/html，容器里面很多命令都没有，如wget，unzip等都没有，建议在本地就弄好

如果需要数据库

1、进入要用到数据库的容器内部：docker exec -it 容器ID /bin/bash
2、进入之后连接数据库：mysql -u root (默认没有密码)
3、可以先看看有什么数据库：SHOW DATABASE;
4、创建数据库：create DATABASE 数据库名;
5、使用数据库：use 数据库名；
6、给数据库创建用户：create user 用户名@localhost identified by '密码'；
7、授权用户：grant all privileges on 数据库名.* to 用户名@localhost;
8、刷新：flush privileges;
9、如写好了.sql的数据库，可导入数据：source 文件的路径 （这个路径是容器路径，一开始要把服务器本地的文件拷贝到容器里）

**运维命令**

1、查看有什么容器和运行情况：docker ps -a
2、进入容器：docker exec -it 容器ID /bin/bash
3、启动容器：docker start 容器ID1 容器ID2 （这个可以启动多个容器）停止容器就把start改为stop即可
4、如果服务器重启了之后docker没启动，可以添加参数保证每次重启之后容器也重启：docker update --restart=always 多个容器ID

> 出题最好写dockerfile 方便比赛选手复现XD

### CTF-Pwn

现在一般 CTF Pwn的环境都是由 xinted + docker 组成。在github上 [xinetd](https://github.com/Eadom/ctf_xinetd) 的项目从权限到服务配置都做好了一个dockerfile 我们只需要build一下就好了..具体步骤如下

- 安装 docker
在 ubuntu环境下，需要以root 安装 docker
sudo apt-get install docker-ce
clone ctf_xinetd项目
git clone https://github.com/Eadom/ctf_xinetd.git
- 配置 docker环境
1、 将你的bin 文件放置到 bin 目录下
2、 修改 flag 文本内容 为你指定的 flag
3、紧接着修改 ctf.xinetd 的服务：
port为指定端口

``` jboss-cli
server_args = --userspec=1000:1000 /home/ctf ./helloworld
```

修改"helloworld"为你的bin文件名称
- build dockerfile
在git下的目录下
`docker build -t "helloworld" .` (注意后面是有个点的），helloword是你编译后image的名称，不要使用bin作为挑战的名称
- 创建容器
docker 的容器相当于是运行了一个虚拟机，创建容器后，就是将镜像跑起来了。

``` dockerfile
docker run -d -p "0.0.0.0:pub_port:9999" -h "helloworld" --name="helloworld" helloworld
```
pub_port 是您要向公共网络公开的端口

如果您想捕获挑战流量，只需tcpdump在主机上运行即可。这是一个例子。

``` stylus
tcpdump -w helloworld.pcap -i eth0 port pub_port
```

**另外**
正常情况下 docker是需要sudo权限才能跑的。所以如果在非root下创建环境，记得用sudo 运行docker


**最后**

复现题目都很简单，出题和部署才需要多实践才能熟练掌握docker在CTF的妙用(23333)