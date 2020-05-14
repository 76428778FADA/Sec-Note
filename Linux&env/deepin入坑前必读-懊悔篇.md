## 因NVIDIA显卡造成开机启动问题

> 此问题与版本无关，是显卡的通病

**第一步：暂时性解决方案，能开机，但是重启后问题依然存在**

1）开机后按`e`，进入启动配置编辑页面

2）然后我们在菜单中的代码中，找到倒数第二行，会出现如下所示的代码：


```
     linux /vmlinuz-4.15.0-29deepin-generic root=UUID=b66d8ffa-aed9-466c-bc12-6bb801e45901 ro splash quiet
```
上面这行表示加载linux内核文件，后面是内核的参数，以下为解释：


 `root`告诉内核根分区的设备；ro表示在设备启动时为`read-only`，如果是rw表示read-write
 `splash`表示开机动画splash表示开机动画
 `quiet`表示在启动过程中只有重要信息显示，类似硬件自检的消息不会显示quiet表示在启动过程中只有重要信息显示，类似硬件自检的消息不会显示
 single以单用户模式登录，一般用于修改系统，比如deepin密码忘记了等等。single以单用户模式登录，一般用于修改系统，比如deepin密码忘记了等等。

3）在quiet的后面空一格加上如下所示的代码：`acpi_osi=! acpi="windows 2009"`，然后按`F10`保存即可。这时会重新开始登录deepin系统，耐心等待进入桌面即可。

**第二步：永久性解决方案，进入系统后修改配置**

1）开机后输入账号和密码，若进入桌面鼠标一直转圈圈，请看下面的解决方案，如果一切正常，则继续操作；

2）按Ctrl+Alt+T进入打开终端，输入以下代码来打开grub配置文件：`sudo gedit /boot/grub/grub.cfg`，如下图所示：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472584236.jpg)


3）成功后会打开你的`grub.cfg`文件，如图所示，然后按Ctrl+F搜索quiet，并在第`第一个quiet`后面空一格加上这行代码：`acpi_osi=! acpi="windows 2009"`，并保存退出。

问题到这里应该就能得到永久解决了！

> kali也有类似的显卡问题无法开机，原理大致相同。

第一步：先想办法进入系统，临时解决方法：进入启动项编辑，在倒数第三行加入了`nouveau.modeset=0`
第二步：永久性解决：
```
    1. 将nouveau添加到黑名单，防止它启动
    cd /etc/modprobe.d $ sudo vi nvidia-graphics-drivers.conf  //写入：blacklist nouveau
    cat nvidia-graphics-drivers.conf     //检查
    2. 对于：/etc/default/grub，添加到末尾。
    sudo vi /etc/default/grub   //末尾写入：rdblacklist=nouveau nouveau.modeset=0
    cat /etc/default/grub   //检查
```
执行官方提供的操作，不成功也没事
```
    $ sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img
    然后重新生成initrd文件
    $ sudo dracut /boot/initramfs-$(uname -r).img $(uname -r) $ sudo update-initramfs -u
```
## 显示设置旋转后导致开机黑屏


![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589472584017.jpg)


这是一个坑，切记不用去点

如果中枪了，可以使用以下解决方案：
开机进入用户登录界面，ctrl+alt+F1-f7

执行以下命令

```
sudo mv ~/.config/deepin/startdde/display.json /
```
reboot重启下就可以进入系统了，之后你再去找到这个配置文件，修改`Rotation`的值为`1`，再mv回去就好了
