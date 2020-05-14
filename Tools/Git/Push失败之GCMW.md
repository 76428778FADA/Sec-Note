原因： github 禁用了 TLS1.0/1.1 协议

截至 2018 年 2 月 22 日，GitHub 禁用了对弱加密的支持，这意味着许多用户会突然发现自己无法使用 Git for Windows 进行身份验证（影响版本低于v2.16.0）唯一的修复方法是[将 Git for Windows 更新](https://github.com/git-for-windows/git/releases)到最新版本（或至少 v2.16.0），并安装GCMW最新版 [参照官网说明](https://git-scm.com/book/zh/v2/Git-工具-凭证存储)

用户看到的最常见的错误如下所示：

```
fatal: HttpRequestException encountered.
   An error occurred while sending the request.
fatal: HttpRequestException encountered.
   An error occurred while sending the request.
Username for 'https://github.com':
```

要使用 GCM（提供安全的 Git 凭证存储），您可以下载[最新的安装程序](https://github.com/Microsoft/Git-Credential-Manager-for-Windows/releases/latest)。要安装，请双击 Setup.exe，然后按照提供的说明进行操作。

Git-Credential-Manager-for-Windows 安装完成后，执行如下命令检查是否启用 GCM 来管理密码：

```
git config --system credential.helper
```

如果返回值是 manager，表示已启用 GCM。如果不是，可以使用下面的命令进行设置：

```
git config --system credential.helper manager
```

设置完成后 GCM 会自动使用 Windows 的凭证管理来进行密码的管理，你只需在第一次访问时需要输入密码，以后的访问无需再输入密码。

如果manager使用后仍然出现不能记住凭证的情况，也不必纠结于加不加密了，个人感觉问题不大，直接用`git config --system credential.helper store` 也是很香的，懒得每次都输入凭证

ps：反复尝试store和manager或许会成功

设置完 GCM 后，如果你更改了远程服务器端的用户密码，会提示如下错误：

```
D:\git>git pull
remote: HTTP Basic: Access denied
fatal: Authentication failed for 'http://xxx.xxx.com/git.git'
```

这是因为远程密码更改后，无法使用本地保存的凭证来进行验证。要解决这个问题，可以使用以下两个方法：

   一、先执行如下命令：

```
git config --global credential.interactive Always
```

当再次执行 pull 或 push 会弹出认证框，填入正确的认证信息后，执行如下命令：

```
git config --global credential.interactive Auto
```

  二、打开 “控制面板 --> 用户账户 -->管理您的凭据”，在这里可以删除已自动保存的凭据或者直接修改密码。