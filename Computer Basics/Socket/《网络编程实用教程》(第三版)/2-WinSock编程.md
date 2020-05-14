### 1.Windows Sockets 

#### 1.1 套接字描述符


在WinSock规范中定义了一个新的数据类型，称作SOCKET，用来代表套接字描述符。

```c++
typedef    u_int     SOCKET;
```

#### 1.2 select()函数和FD_*宏

在Winsock中，使用select()函数时，应用程序应坚持用FD_XXX宏来设置，初始化，清除和检查fd_set结构。 

#### 1.3 错误代码的获得

在UNIX 套接字规范中，如果函数执行时发生了错误，会把错误代码放到errno或h_errno变量中.在Winsock中，错误代码可以使用`WSAGetLastError()`调用得到

#### 1.4 指针

所有应用程序与Windows Sockets使用的指针都必须是`FAR`指针。

#### 1.5 重命名的函数

(1)  close()改变为closesocket()
(2)  ioctl()改变为ioctlsocket() 

#### 1.6 Winsock支持的最大套接口数目

在WINSOCK.H中缺省值是64，在编译时由常量FD_SETSIZE决定。

#### 1.7 头文件和库文件

一个Windows Sockets应用程序只需简单地包含WINSOCK.H和wsock32.dll就足够了。

```c
#include <winsock.h>
#pragma comment(lib,"wsock32.lib")
```

#### 1.8 Winsock规范对于消息驱动机制的支持

体现在异步选择机制、异步请求函数、阻塞处理方法、错误处理、启动和终止等方面。 


###　2.Winsock库函数

#### 2.1 初始化函数WSAStartup()

（1）WSAStartup()函数的调用格式
```c++
  int  WSAStartup(WORD  wVersionRequested, LPWSADATA lpWSAData );
```
（2）WSAStartup()函数的初始化过程

![](https://raw.githubusercontent.com/Qymua/bookmaker-data/master/Qymua/1571927359070.png)

首先，检查系统中是否有一个或多个WinSock实现的实例(查找Winsock.dll文件)

其次，检查找到的WinSock实例是否可用，主要是确认WinSock实例的版本号

再者，要建立WinSock实现与应用程序的联系，由于windows是多任务多线程的操作系统，因此一个WinSock.dll库可以同时为多个并发的网络应用程序服务

最后，函数成功返回时，会在IpWSAData所指向的WSADATA结构中返回许多信息、

(3) WSADATA结构的定义

```c++
#define WSADESCRIPTION_LEN      256
#define WSASYS_STATUS_LEN       128
typedef struct WSAData {
  WORD         wVersion; //Winsock版本号
  WORD         wHighVersion; //dll支持的最高版本
  char         szDescription[WSADESCRIPTION_LEN+1]; //WinSock描述信息 "\0"结尾
  char         szSystemStatus[WSASYS_STATUS_LEN+1]; //系统状态和配置信息  "\0"结尾
  unsigned short   iMaxSockets; //一个进程最多可以使用的套接字个数
  unsigned short   iMaxUdpDg; //可以发送的最大数据报的字节数 最小值通常是通常是512
  char *         lpVendorInfo;  
} WSADATA; 
```
(4) 初始化函数可能返回的错误代码

WSASYSNOTREADY:网络通信依赖的网络子系统没有准备好。

WSAVERNOTSUPPORTED:找不到所需的Winsock API相应的动态连接库。

WSAEINVAL:DLL不支持应用程序所需的Winsock版本。

WSAEINPROGRESS:正在执行一个阻塞的Winsock 1.1操作。

WSAEPROCLIM:已经达到Winsock支持的任务数上限。

WSAEFAULT:参数lpWSAData不是合法指针。 

(5) 初始化Winsock的示例

```c++
#include <winsock.h>           
// 对于Winsock 2.0，应包括 Winsock2.h文件
aa() {
WORD wVersionRequested;  
  // 应用程序所需的Winsock版本号
WSADATA wsaData;       
  // 用来返回Winsock 实现的细节信息。
Int err;                   
  // 出错代码。 
wVersionRequested =MAKEWORD(1,1);          // 生成版本号1.1
// 调用初始化函数。
err = WSAStartup(wVersionRequested, &wsaData );                                                                            
if (err!=0 ) { return;}              // 通知用户找不到合适的DLL文件
// 确认返回的版本号是客户要求的1.1
if ( LOBYTE(wsaData.wVersion )!=1 || HYBYTE(wsaData.wVersion )!=1) {
WSACleanup(); 
return;
} 
// 至此，可以确认初始化成功，Winsock.DLL可用
} 
```

#### 2.2 注销函数WSACleanup()

当程序使用完Winsock.DLL提供的服务后，应用程序必须调用WSACleanup()函数，来解除与Winsock.DLL库的绑定，释放Winsock实现分配给应用程序的系统资源，中止对Windows Sockets DLL的使用。 
```c++
 int WSACleanup ( void ); 
```

#### 2.3 Winsock的错误处理函数

1) WSAGetLastError()函数
`int WSAGetLastError ( void )`;
本函数返回本线程进行的上一次Winsock函数调用时的错误代码。
2) WSASetLastError()函数
`void WSASetLastError ( int iError )`;
本函数允许应用程序为当前线程设置错误代码，并可由后来的WSAGetLastError()调用返回。

####　2.4 主要的Winsock函数

1) 创建套接口socket()	
`SOCKET  socket (int af, int type, int protocol)`;
举例：

```c++
// 创建一个流式套接字
SOCKET sockfd=SOCKET( AF_INET, SOCK_STREAM, 0);                 
//创建一个数据报套接字
SOCKET sockfd=SOCKET( AF_INET, SOCK_DGRAM, 0);              
```
**套接字类型1：面向连接的套接字（SOCK_STREAM**）

如果 socket 函数的第二个参数传递`SOCK_STREAM`，将创建面向连接的套接字。

传输方式特征整理如下：

- 传输过程中数据不会消失
- 按序传输数据
- 传输的数据不存在数据边界（Boundary）

这种情形适用于之前说过的 write 和 read 函数

> 传输数据的计算机通过调用3次 write 函数传递了 100 字节的数据，但是接受数据的计算机仅仅通过调用 1 次 read 函数调用就接受了全部 100 个字节。

收发数据的套接字内部有缓冲（buffer），简言之就是字节数组。只要不超过数组容量，那么数据填满缓冲后过 1 次 read 函数的调用就可以读取全部，也有可能调用多次来完成读取。

**套接字缓冲已满是否意味着数据丢失？**

> 答：缓冲并不总是满的。如果读取速度比数据传入过来的速度慢，则缓冲可能被填满，但是这时也不会丢失数据，因为传输套接字此时会停止数据传输，所以面向连接的套接字不会发生数据丢失。

套接字联机必须一一对应。面向连接的套接字可总结为：

**可靠地、按序传递的、基于字节的面向连接的数据传输方式的套接字。**

**套接字类型2： 面向消息的套接字（SOCK_DGRAM）**

如果 socket 函数的第二个参数传递`SOCK_DGRAM`，则将创建面向消息的套接字。面向消息的套接字可以比喻成高速移动的摩托车队。特点如下：

- 强调快速传输而非传输有序
- 传输的数据可能丢失也可能损毁
- 传输的数据有边界
- 限制每次传输数据的大小

面向消息的套接字比面向连接的套接字更具哟传输速度，但可能丢失。特点可总结为：

不可靠的、不按序传递的、以数据的高速传输为目的套接字。

**socket 函数的第三个参数决定最终采用的协议**。前面已经通过前两个参数传递了协议族信息和套接字数据传输方式，这些信息还不够吗？为什么要传输第三个参数呢？

> 可以应对同一协议族中存在的多个数据传输方式相同的协议，所以数据传输方式相同，但是协议不同，需要用第三个参数指定具体的协议信息。

本书用的是 Ipv4 的协议族，和面向连接的数据传输，满足这两个条件的协议只有 TPPROTO_TCP ，因此可以如下调用 socket 函数创建套接字，这种套接字称为 TCP 套接字。

```c
int tcp_socket = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
```

SOCK_DGRAM 指的是面向消息的数据传输方式，满足上述条件的协议只有 TPPROTO_UDP 。这种套接字称为 UDP 套接字：

```c
int udp_socket = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
```

2) 将套接口绑定到指定的网络地址bind()

`int bind( SOCKET s,  const struct sockaddr * name,  int namelen)`;

Winsock定义的三种地址结构，和UNIX socket基本一样

①通用的Winsock地址结构，针对各种通信域的套接字，存储它们的地址信息。
```c++
struct sockaddr {
    u_short     sa_family;                        /* 地址家族
    char          sa_data[14];                      /* 协议地址
} 
```
此结构体 sa_data 保存的地址信息中需要包含IP地址和端口号，剩余部分应该填充 0 ，但是这样对于包含地址的信息非常麻烦，所以出现了 sockaddr_in 结构体，然后强制转换成 sockaddr 类型，则生成符合 bind 条件的参数。

②专门针对Internet 通信域的Winsock地址结构

```c++
struct sockaddr_in {
// 指定地址家族，一定是AF_INET 
short.         sin_family; 
// 指定将要分配给套接字的传输层端口号,
u_short       sin_port;    
 // 指定套接字的主机的IP 地址
struct in_addr  sin_addr; 
//全置为0，是一个填充数。
char          sin_zero[8];} 
```
③专用于存储IP地址的结构
```c++
Struct in_addr {
    Union {	
         Struct {u_char s_b1,s_b2,s_b3,s_b4;} S_un_b;
         Struct {u_short s_w1,s_w2;} S_un_w;
         U_long  S_addr;
    }
}
```

在使用Internet域的套接字时，这三个数据结构的一般用法是：

1.首先，定义一个Sockaddr_in的结构实例变量，并将它清零。

2.然后，为这个结构的各成员变量赋值，一般用函数inet_addr()把字符串形式的IP地址转换成长整型后赋给s_addr，也可以使用htonl(INADDR_ANY),使用本地的任意地址

3.第三步，在调用BIND()绑定函数时，将指向这个结构的指针强制转换为 sockaddr*类型。  

**举例**：

```c++
SOCKET serSock;                // 定义了一个SOCKET 类型的变量
// 定义一个Sockaddr_in型的结构实例变量。
sockaddr_in my_addr;   
int err;                                      // 出错码 
int slen=sizeof( sockaddr);     // sockaddr 结构的长度
// 创建数据报套接字
serSock = SOCKET(AF_INET, SOCK_DGRAM,0 );  
// 将Sockaddr_in的结构实例变量清零   
memset(my_addr，0);                     
my_addr.sin_family = AF_INET;             // 指定通信域是Internet
// 指定端口，将端口号转换为网络字节顺序
my_addr.sin_port = htons(21);               
/* 指定IP地址，将IP地址转换为网络字节顺序*/
my_addr.sin_addr.s_addr = htonl( INADDR-ANY); 
/* 将套接字绑定到指定的网络地址，对&my_addr进行了强制类型转换*/
if  (BIND(serSock, (LPSOCKADDR )&my_addr, slen) == SOCKET_ERROR )
{
/* 调用WSAGetLastError()函数，获取最近一个操作的错误代码*/
err = WSAGetLastError();
/* 以下可以报错，进行错误处理*/
} 
```

3) 启动服务器监听客户端的连接请求listen()
`int  listen( SOCKET s, int backlog)`;

4) 接收连接请求accept()
`SOCKET  accept( SOCKET s, struct sockaddr* addr, int* addrlen)`;

5) 请求连接connect()
`int  connect( SOCKET s, struct sockaddr * name, int namelen)`; 

6) 向一个已连接的套接口发送数据send()
`int  send( SOCKET s, char * buf, int len, int flags)`; 

![](https://raw.githubusercontent.com/Qymua/bookmaker-data/master/Qymua/1571929933845.png)

7) 从一个已连接套接口接收数据recv()
` int  recv( SOCKET s, char * buf, int len, int flags)`;

下图说明了send和recv的作用，套接字缓冲区与应用进程缓冲区的关系，以及协议栈所作的传送。 

![](https://raw.githubusercontent.com/Qymua/bookmaker-data/master/Qymua/1571930016556.png)

8) 按照指定目的地向数据报套接字发送数据 sendto()
`int  sendto( SOCKET s, char * buf, int len, int flags, struct sockaddr * to, int tolen)`; 

```c++
int PASCAL FAR sendto ( SOCKET s,  //套接字的描述符
const char FAR* buf,  //存放要传送的数据的缓冲区
int len,               //buf的长度
int flags,            //函数的调用方式
const struct socketaddr FAR* to,   //数据要送达的套接字地址
int tonlen                     //to的大小 )
```

函数返回值：如果sendto()函数发送数据报顺利完成，它将返回实际发送的字节数，若有错误，函数将返回SOCKET_ERROR。可以通过调用WSAGetLastError()查找错误原因。

9) 接收一个数据报并保存源地址，从数据报套接字接收数据recvfrom()
`int recvfrom( SOCKET s, char * buf, int len, int flags, struct sockaddr* from, int* fromlen)`; 

```c++
int PASCAL FAR recvfrom ( SOCKET s,  //套接字的描述符
char FAR* buf,  //存放接收到的数据的缓冲区
int len,               //buf的长度
int flags,            //函数的调用方式
struct socketaddr FAR* from,   //数据来源的套接字地址
int FAR* fromlen                     //from的大小 )
```

函数返回值：如果数据报读入成功的话，函数将返回实际接受到的字节数，若有错误，函数将返回SOCKET_ERROR。可以通过调WSAGetLastError()查找错误原因。

10) 关闭套接字closesocket()
`int closesocket( SOCKET s)`; 

11) 禁止在一个套接口上进行数据的接收与发送shutdown()
`int shutdown( SOCKET s, int how)`; 

####　2.5　Winsock的信息查询函数

Winsock API提供了一组信息查询函数，让我们能方便地获取套接口所需要的网络地址信息以及其它信息
返回的信息存放在特定的数据结构中
```c++
struct hostent{
   char * h_name;
   char * * h_aliases;
   short h_addrtype; //AF_INET
   short h_length;
   char * * h_addr_list;}

struct servent{
    char * s_name;
    char * * s_aliases;
    short   s_port;
    char * s_proto;
} 
```

(1)  gethostname()
用来返回本地计算机的标准主机名。
`int gethostname(char* name,  int namelen)`;
(2)  gethostbyname()
返回对应于给定主机名的主机信息。
`struct hostent*  gethostbyname(const  char* name)`; 
(3)  gethostbyaddr()
根据一个IP地址取回相应的主机信息。
`struct hostent* gethostbyaddr(const char* addr, int len, int type)`;
(4)  getservbyname()
返回对应于给定服务名和协议名的相关服务信息。
 `struct servent* getservbyname(const char* name, const char* proto)`;
(5)  getservbyport()
返回对应于给定端口号和协议名的相关服务信息。
`struct servent * getservbyport(int port,const char *proto)`; 
（6）getprotobyname()
返回对应于给定协议名的相关协议信息。
 `struct protoent *  getprotobyname(const char * name)`;
（7）getprotobynumber ()
返回对应于给定协议号的相关协议信息。
`struct protoent * getprotobynumber(int number)`;

**除了gethostname()函数以外，其它六个函数有以下共同的特点：**

①函数名都采用GetXbyY的形式。 

②如果函数成功地执行，就返回一个指向某种结构的指针，该结构包含所需要的信息。

③如果函数执行发生错误，就返回一个空指针。应用程序可以立即调用WSAGetLastError()来得到一个特定的错误代码。

④六个函数，与GetXbyY各函数对应，在每个函数名前面加上了WSAAsync前缀，名字采用WSAAsyncGetXByY()的形式。

```c++
#include "Winsock.h"
#include "windows.h"
#include "stdio.h"
#include "string.h"
#pragma comment(lib,"wsock32.lib")

 int len;
 
/*********
函数名：
函数功能：
输入：
输出：
********/
int GetnetPort()
{
	
	short port;
	printf("请输入端口号 ：");  
	scanf("%d",&port); 
	printf("网络字节顺序：%d\n",htons(port));
	return 0;
}
int  GetnetIP()
{
	printf("请输入IP地址 ：");
	char IP[20];
	scanf("%s",IP) ;
	printf("%s 主机字节顺序：%ld\n",IP,(u_long)inet_addr(IP));	
	return 0;
}


int GetIPbyName()
{
	char name[20];
	memset(name,0,20);

    printf("请输入主机名 ：");
	scanf("%s",name); 

hostent * host=gethostbyname(name);
   if(!host)
       return -1;
  struct sockaddr_in mac;
    mac.sin_family=AF_INET;
    memcpy(&mac.sin_addr,host->h_addr_list[0],host->h_length);
    //得到实际的IP地址
    char * ip=inet_ntoa(mac.sin_addr);

   if(!ip)
       return -1;
    printf("%s\n",ip);

    return strlen(ip);
}

int GetNameByIP()
{
	char ip[15];
 memset(ip,0,15);
 	char name[20];
	memset(name,0,20);
 printf("请输入主机IP ：");
	scanf("%s",ip); 
unsigned int node=inet_addr(ip);
if(node==INADDR_NONE)
      return -1;
struct hostent * phost=gethostbyaddr((char *)&node,4,AF_INET);//得到机器信息
if(!phost)
     return -1;
  len=strlen(phost->h_name);
memcpy(name,phost->h_name,len);
printf("%s\n",name);
return strlen(name);
}


void main()
{ 
WSADATA wsaData;
if(WSAStartup(MAKEWORD(1,1),&wsaData)!=0)
    return ;

int on;

while(1)
{
	printf("1-根据端口号查询\n");
	printf("2-根据IP查询\n");
	printf("3-根据主机名查询IP\n");
	printf("4-根据IP查询主机名\n");
	printf("5-退出\n");
	scanf("%d",&on);
	
	if(on == 5)
                  break;
	system("cls");
	switch(on){
	case 1: GetnetPort();break;
	case 2: GetnetIP();break;
	case 3: GetIPbyName();break;
	case 4: GetNameByIP();break;
	break;
	}
	scanf("%c",&on);
}
WSACleanup();
return ;


}
```

#### 2.6 应用拓展-广播通信

（1）创建广播套接字
创建数据报套接字：`socket()`
绑定数据报套接字于指定的地址和端口：`bind()`
通过套接字选项设置数据报套接字的广播属性：`setsockopt()`
（2）发送广播消息：`sendto()`，发送地址必须设为`INADDR_BROADCAST`（广播地址）;接收广播消息：`recvfrom()`
（3）关闭套接字，结束通信。

`setsockopt()` 函数：           
功能：设置套接字选项
函数原型：

```c++
int setsockopt(SOCKET s,int level,int optname,const char FAR* optval,int optlen);
```
参数说明：
`s`：套接字句柄
`level`：代表欲设置的网络层次，例如，若设为SOL_SOCKET，表示在socket层进行设置，若为`IPPROTO_IP`表示在IP层进行设置
`optname`：设置的选项名，若要设置套接字的广播属性，参数值为SOCKET_BROADCAST
`optval`：选项值buffer指针
`optlen`：选项buffer长度

```c++
/*---广播通信
实现面向无连接的服务端向多个客户端发送数据
接收端：client.cpp
绑定本地网络地址：sin
接收广播数据套网络地址：sin_from
广播端口：3779
*/

#include "stdio.h"
#include "winsock.h"
#pragma comment(lib,"wsock32.lib")

SOCKET s;
SOCKADDR_IN sin;
SOCKADDR_IN sin_from;
int err;

const int MAX_BUF_LEN = 255; //buff

DWORD StartWSA() //启动api
{

	WSADATA WSAdata;
	if(WSAStartup(MAKEWORD(2,2),&WSAdata)!=0)
	{
		printf("sock init fail!\n");
		return(-1);
	}

    return(1);
}

DWORD CreateSocket() //配置套接字
{
	s=socket(AF_INET,SOCK_DGRAM,0);
	if(s==SOCKET_ERROR)
	{
		printf("sock create fail!\n");
		WSACleanup();
		return(-1);
	}

    sin.sin_family = AF_INET;
	sin.sin_port = htons(3779);
	sin.sin_addr.s_addr = htonl(INADDR_ANY);

    sin_from.sin_family = AF_INET;
	sin_from.sin_port = htons(3779);
	sin_from.sin_addr.s_addr = INADDR_BROADCAST;

    //设置广播套接字
    bool yes = true;
	setsockopt(s, SOL_SOCKET, SO_BROADCAST, (char*)&yes, sizeof(yes)); 

    //绑定套接字
    err = bind(s,(LPSOCKADDR)&sin, sizeof(sin));
	if(SOCKET_ERROR == err)
	{
		err = WSAGetLastError();
		printf("bind error! \n error code is %d\n", err);
		return(-1);
	}

	return(1);
}

//接收函数
DWORD Recv()
{
    int nAddrLen = sizeof(SOCKADDR);
	char buff[MAX_BUF_LEN] = "";
	int nLoop = 0;
	while(1)
	{
		int nSendSize = recvfrom(s, buff, MAX_BUF_LEN, 0, (SOCKADDR*)&sin_from, &nAddrLen);
		if(SOCKET_ERROR == nSendSize)
		{
			err = WSAGetLastError();
			printf("recvfrom error! error code is %d\n", err);
			return(-1);
		}
		buff[nSendSize] = '\0';
		printf("Recv: %s\n", buff);
	}

}

int main()
{
    if (StartWSA() == -1)
        return(-1);
    if (CreateSocket() == -1)
		return(-1);
    if (Recv() == -1)
        return(-1);
    return(1);
}
```

```c++
/*---广播通信
实现面向无连接的服务端向多个客户端发送数据
接收端：server.cpp
绑定本地网络地址：sin
接收广播数据套网络地址：sin_from
广播端口：3779
*/

#include "stdio.h"
#include "winsock.h"
#pragma comment(lib,"wsock32.lib")

SOCKET s;
SOCKADDR_IN sin;
int err;

const int MAX_BUF_LEN = 255;

DWORD StartWSA() //启动api
{

	WSADATA WSAdata;
	if(WSAStartup(MAKEWORD(2,2),&WSAdata)!=0)
	{
		printf("sock init fail!\n");
		return(-1);
	}

    return(1);
}

//配置套接字
DWORD CreateSocket()
{
	s=socket(AF_INET,SOCK_DGRAM,0);
	if(s==SOCKET_ERROR)
	{
		printf("sock create fail!\n");
		WSACleanup();
		return(-1);
	}

    sin.sin_family = AF_INET;
	sin.sin_port = htons(3779);
	sin.sin_addr.s_addr =INADDR_BROADCAST;

    //设置广播套接字选项
    bool yes = true;
	setsockopt(s, SOL_SOCKET, SO_BROADCAST, (char*)&yes, sizeof(yes));

	return(1);
}

//发送函数
DWORD send()
{
    int nAddrLen = sizeof(SOCKADDR);
	char buff[MAX_BUF_LEN] = "";
	int nLoop = 0;
	while(1)
	{
		nLoop++;
		sprintf(buff, "%3d", nLoop);
		int nSendSize = sendto(s, buff, strlen(buff), 0, (SOCKADDR*)&sin, nAddrLen);
		if(SOCKET_ERROR == nSendSize)
		{
			err = WSAGetLastError();
			printf("sendto error! \n error code is %d\n", err);
			return(-1);
		}
		printf("Send: %s\n", buff);
		Sleep(500);
	}


}

int main()
{
    if (StartWSA() == -1)
        return(-1);
    if (CreateSocket() == -1)
		return(-1);
    if (send() == -1)
        return(-1);
    return(1);
}
```

### 3. 通信程序设计

#### 3.1 数据报通信基本步骤

数据报通信程序采用的是`SOCK_DGRAM`（数据报套接字），它是无连接的。数据报套接字的编程模型使用的基本Winsock函数（例如socket()、bind()、closesocket()）和数据发送与接收函数，只是创建套接字时要选择SOCK_DGRAM的套接字类型，例如：

`Sock=socket(AF_INET, SOCK_DGRAM, 0)`

但是数据传输函数需要指定地址或者接收地址，发送数据用sendto函数，接收数据用recvfrom函数。

![](https://raw.githubusercontent.com/Qymua/bookmaker-data/master/Qymua/1571960957222.png)

（1）通信A端和B端都要创建一个数据报套接字：socket()

（2）A端调用bind()给创建的套接字分配地址（包括IP地址和端口号），B端同样也需要对它的套接字进行绑定；单向通信，发送端可以不绑定

（3）A端和B端都可以使用sendto发送数据，使用recvfrom接收数据；

recvfrom的两个参数，from,fromlen对接收不起作用，仅用来返回数据报源端的网络地址

（4）通信结束时，双方调用closesocket()关闭套接字。

```c++
/*使用UDP实现数据通信
接收端：client.cpp
*/
#include "winsock.h"
#include "stdio.h"
#pragma comment(lib,"wsock32.lib")
#define RECE_PORT 2000
#define SEND_PORT 3000
#define SERVERADDR "127.0.0.1"
#define CLIENTADDR "127.0.0.1"

SOCKET sock;
SOCKADDR_IN serveraddr;

DWORD StartSock()
{

	WSADATA WSAdata;
	if(WSAStartup(MAKEWORD(2,2),&WSAdata)!=0)
	{
		printf("sock init fail!\n");
		return(-1);
	}
	serveraddr.sin_family= AF_INET;
	serveraddr.sin_addr.s_addr= inet_addr(SERVERADDR);
	serveraddr.sin_port=htons(RECE_PORT);
	return(1);
}

DWORD CreateSocket()
{
	sock=socket(AF_INET,SOCK_DGRAM,0);
	if(sock==SOCKET_ERROR)
	{
		printf("sock create fail!\n");
		WSACleanup();
		return(-1);
	}
	printf("Successfully!\n Continue after Eenter!\n");
	return(1);
}

DWORD Udpsend(char data[])
{
    int length;
    length = sendto(sock,data,strlen(data),0,(struct sockaddr *)&serveraddr,sizeof(serveraddr));

    if(length<=0)
    {
        printf("send data error!\n");
        closesocket(sock);
        WSACleanup();
        return(-1);
    }
    return(1);
}

void main()
{
    char buff[80];
    StartSock();
    CreateSocket();
    printf("press any message to send!\n");
	for (;;)
	{
		memset(buff, 0, 80);
		printf("发送信息:");
		scanf("%s", &buff);
		Udpsend(buff);
		Sleep(100);
		
	}
}
```

```c++
/*使用UDP实现数据通信
接收端：Server.cpp
*/
#include "winsock.h"
#include "stdio.h"
#include "windows.h"
#pragma comment(lib,"wsock32.lib")
#define RECE_PORT 2000
#define SEND_PORT 3000
#define SERVERADDR "127.0.0.1"
#define CLIENTADDR "127.0.0.1"

SOCKET sock;
SOCKADDR_IN serveraddr;
SOCKADDR_IN Client;

DWORD StartSock()
{

	WSADATA WSAdata;
	if(WSAStartup(MAKEWORD(2,2),&WSAdata)!=0)
	{
		printf("sock init fail!\n");
		return(-1);
	}
	
	serveraddr.sin_family= AF_INET;
	serveraddr.sin_addr.s_addr= inet_addr(SERVERADDR);
	serveraddr.sin_port=htons(RECE_PORT);
	
	return(1);
}

DWORD CreateSocket()
{
	sock=socket(AF_INET,SOCK_DGRAM,0);
	if(sock==SOCKET_ERROR)
	{
		printf("sock create fail!\n");
		WSACleanup();
		return(-1);
	}
	if(bind(sock,(struct sockaddr *)&serveraddr,sizeof(serveraddr))==SOCKET_ERROR)
	{
		printf("bind is the error");
		closesocket(sock);
		WSACleanup();
		return(-1);
	}
	return(1);
}

DWORD UdpRecv()
{
	char RecvBuff[80];
	int RecvLength=0;
	int alen;
	alen=sizeof(Client);
	printf("Waiting for recv....\n");
	for(;;)
	{
		memset(RecvBuff,0,80);
		RecvLength=recvfrom(sock,RecvBuff,80,0,(struct sockaddr *)&Client,&alen);
		if(RecvLength<0)
		{
			printf("data receive fail\n");
			closesocket(sock);
			WSACleanup();
			return(-1);
		}
		else
		{
			if(strcmp(RecvBuff,"exit")==0)
			break;
			printf("收到信息:%s\n",RecvBuff);
		}
		
	}
	return(1);
}

void main()

{
	StartSock();
	CreateSocket();
	UdpRecv();
}
```


#### 3.2 会话通信基本步骤

会话通信程序采用的是基于连接的协议，因此用户在传输、接收数据之前必须首先建立连接。

![](https://raw.githubusercontent.com/Qymua/bookmaker-data/master/Qymua/1571961055866.png)

**服务器端应用程序的基本步骤：**

① 打开socket，即创建套接字：socket()
——该socket主要用于侦听客户端的连接请求，因而通常也称作侦听socket

② 为侦听socket分配地址，通常与本机地址绑定在一起：bind()

③ 在侦听socket上监听客户端的连接请求：listen()

④ 侦听socket收到客户端的连接请求后，服务器建立与客户端的连接，并生成一个连接socket：accept()

⑤ 利用连接socket进行数据传输：send()、recv()

⑥ 数据传输结束后，关闭用于侦听和连接的Socket：closesocket()

**客户端应用程序的基本步骤：**

① 客户端打开socket，即创建客户端套接字：socket()

② 将socket与本机地址绑定在一起：bind()
   ——该步可省略 因为客户端是连接请求方，与UDP发送端可忽略同理
③ 向服务器发出连接请求：connect()

④ 建立连接后，就可以进行数据传输：send()、recv()

⑤ 传输结束后，关闭socket：closesocket()

```c++
//Date-Client.cpp
#include "Winsock.h"
#include "windows.h"
#include "stdio.h"
#pragma comment(lib,"wsock32.lib")
#define RECV_PORT 2000
#define SEND_PORT 3000
#define SERVERADDR "127.0.0.1"

SOCKET sock;
sockaddr_in ServerAddr;

DWORD StartSock()
{
	WSADATA WSAData;
	if (WSAStartup(MAKEWORD(2, 2), &WSAData) != 0)//初始化套接字

	{
		printf("sock init fail!\n");
		return(-1);
	}
	ServerAddr.sin_family = AF_INET;//填充服务器地址端口号
	ServerAddr.sin_addr.s_addr = inet_addr(SERVERADDR);
	ServerAddr.sin_port = htons(RECV_PORT);
	return(1);
}

DWORD CreateSocket()
{
	sock = socket(AF_INET, SOCK_STREAM, 0);//创建套接字

	if (sock == SOCKET_ERROR)
	{
		printf("sock create fail!\n");
		WSACleanup();
		return(-1);
	}

	return(1);
}

DWORD CallServer()
{
	CreateSocket();
	if (connect(sock, (struct sockaddr *)&ServerAddr, sizeof(ServerAddr)) == SOCKET_ERROR)

	{
		printf("Connect fail\n");
		closesocket(sock);

		return(-1);
	}
	return(1);
}

DWORD TCPSend(char data[])
{
	int length=0;
	length = send(sock, data, strlen(data), 0);

	if (length <= 0)
	{
		printf("send data error!\n");
		closesocket(sock);
		WSACleanup();
		return(-1);
	}
	return(1);
}

int main()
{
	char buff[80];
	int num, i;
	StartSock();
	while (CallServer() == -1);
	printf("connect ok!\n");
	printf("press any key to send!");
	getchar();
	for (;;)
	{
		printf("Input the number of message to send: (0-exit)");
		memset(buff, 0, 80);
		scanf("%d", &num);
		if (num <= 0)
			break;
		for (i = 0; i < num; i++)
		{
			sprintf(buff, "data %d\n", i);
			printf(buff);
			TCPSend(buff);
			Sleep(100);
		}
	}
	return(0);
}
```

```c++
//Date-Server.cpp
#include "Winsock.h"
#include "windows.h"
#include "stdio.h"
#pragma comment(lib,"wsock32.lib")
#define RECV_PORT 2000
#define SEND_PORT 3000
#define SERVERADDR "127.0.0.1"

SOCKET sock, sock1;//sock监听套接字，sock1处理套接字
SOCKADDR_IN ServerAddr;
SOCKADDR_IN ClientAddr;
int Addrlen;

DWORD StartSock()
{		
	WSADATA WSAData;
	if (WSAStartup(MAKEWORD(2, 2), &WSAData) != 0)//初始化套接字
	
	{
		printf("sock init fail!/n");
		return(-1);
	}
	return(1);
}

DWORD CreateSocket()
{
	sock = socket(AF_INET, SOCK_STREAM, 0);//创建套接字

	if (sock == SOCKET_ERROR)
	{
		printf("sock create fail!/n");
		WSACleanup();
		return(-1);
	}
	ServerAddr.sin_family = AF_INET;//填充服务器地址端口号
	//ServerAddr.sin_addr.s_addr = htonl(INADDR_ANY);//任何IP地址
	ServerAddr.sin_addr.s_addr = inet_addr(SERVERADDR);
	ServerAddr.sin_port = htons(RECV_PORT);//IP地址上的端口

	if (bind(sock, (struct sockaddr FAR *)&ServerAddr, sizeof(ServerAddr)) == SOCKET_ERROR)
		
	{
		printf("bind is the error");
		return(-1);
	}
	return(1);
}

DWORD ConnectProcess()
{
	char buff[80];
	Addrlen = sizeof(ClientAddr);
    ClientAddr.
	if (listen(sock, 5) < 0)
		
	{
		printf("Listen error");
		return(-1);

	}
	printf("Listening...\n");
	for (;;)
	{
		sock1 = accept(sock, (struct sockaddr FAR *)&ClientAddr, &Addrlen); 
        //链接成功，返回到新创建的套接字描述符sock1，以后就通过这个新的套接字与客户端套接字通信
		
		for (;;)
		{
			memset(buff, 0, 80);
			if (recv(sock1, buff, 80, 0) <= 0)
			
			{
				break;
			}
			printf(buff);
		
		}
	}
}

int main()
{
	if (StartSock() == -1)
		return(-1);
	if (CreateSocket() == -1)
		return(-1);
	if (ConnectProcess() == -1)
		return(-1);
	return(1);
}
```

