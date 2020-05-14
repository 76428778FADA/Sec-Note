> pyenv使你可以轻松地在多个版本的Python之间切换

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473266063.png)

安装
--

首先当然是安装 pyenv 了，最简单的办法就是利用官方 Github 仓库中的安装脚本了：

```
$ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

Macos : brew install pyenv
```

安装脚本有可能会提示你手动把几行命令添加到 shell 的配置文件中。

如果你用的是 zsh 的话，别忘了替换命令中的 bash。将来如果要删除的话，需要在`.zshrc`文件中删除。如果你用 oh-my-zsh 的话，不需要在`.zshrc`中添加那几行（加了也没用），而是在`.zshrc`中启用 pyenv 插件。

将来要进行更新的话：

要卸载 pyenv 的话更加简单，直接删除目录即可：

别忘了把`.bashrc`中的这几行也一并删掉：

```
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

工作原理
----

### Linux 环境变量

当执行命令的时候，系统会在环境变量中从左到右依次寻找匹配的命令并执行。环境变量中是一组以冒号`:`分隔的路径。

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473266065.png)

环境变量

### 垫片（Shims）

pyenv 的工作原理其实很简单，将它自己管理的 Python 目录插到环境变量的最前面，这样一来系统在搜索 Python 的时候第一个找到的就是 pyenv 管理的 Python 环境。这个插到最前面的路径就叫做垫片（shims），当然这是在英文语境下，在中文环境下我老觉得怪怪的，反正理解意思就好。

### 选择 Python 版本

当执行 pyenv 命令的时候，它会按照以下顺序来决定要使用的 Python 版本：

1.  使用`PYENV_VERSION`环境变量 (如果存在). 你可以使用 [`pyenv shell`](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md#pyenv-shell) 命令来在当前 shell 环境中设置该环境变量.
2.  当前目录中应用程序指定的`.python-version`文件 (如果存在). 你可以用 [`pyenv local`](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md#pyenv-local) 命令来修改当前目录的`.python-version`文件.
3.  自底向上搜索各层上级目录，找到的第一个`.python-version`, 直到到达文件系统根目录.
4.  全局的`$(pyenv root)/version`文件. 可以使用 [`pyenv global`](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md#pyenv-global) 命令来修改. 如果全局版本文件不存在, pyenv 假设你使用系统安装的 Python. (换句话说就是未安装 pyenv 时环境变量中找到的 Python.)

常用命令
----

完整命令请参考[官方文档](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md)。

### 安装

列出所有可安装的 Python 版本：pyenv install -l

安装某个 Python：pyenv install 版本号

```bash
pyenv install 3.6.2 # 安装版本(很慢，默认的源很卡)

# 默认的安装源很卡，建议用以下方式安装：
v=3.6.2|wget http://mirrors.sohu.com/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/;pyenv install $v 
# 用国内源安装很快
# 也可以尝试在命令行输入下面的命令，用v=?指定python版本
v=2.7.9;wget http://npm.t
aobao.org/mirrors/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/;pyenv install $v
```

### 卸载

卸载某个 Python，`-f`参数指定是否强制卸载，如果强制卸载的话不会弹出提示，而且如果版本不存在的话也不会显示错误信息：

```
pyenv uninstall [-f|--force] <version>
```

### versions

列出所有已安装的 Python，当前使用的 Python 会用星号标出：

```
$ pyenv versions
  2.5.6
  2.6.8
* 2.7.6 (set by /home/yyuu/.pyenv/version)
  3.3.3
  jython-2.5.3
  pypy-2.2.1
  
$ pyenv version 
  system (set by /root/.pyenv/version)  # system表示系统安装的版本
```

### global

通过写`~/.pyenv/version`文件的方式设置全局 Python：`pyenv global 3.6.2` # 全局设置版本

### local

通过在当前目录写`.python-version`文件的方式设置当前目录下的 Python：

```bash
pyenv local 3.6.2 # 局部设置版本，当前目录生效
pyenv versions    
  system
* 3.6.2 (set by /root/.pyenv/version)
```

当不再需要本地 Python 的时候，清除：pyenv local --unset

### shell

指定当前 shell 使用的 Python：pyenv shell 3.6.6

当不再需要的时候，清除：pyenv shell --unset

最后展示一下`pyenv install -l`的输出，可以看到，pyenv 可以方便的安装大部分版本的 Python，省略号表示中间有一大堆：

```
yitian@ubuntu:~ $ pyenv install -l
Available versions:
  2.1.3
  ...
  2.7.15
  ...
  3.6.6
  3.7.0
  3.7-dev
  3.8-dev
  activepython-2.7.14
  activepython-3.5.4
  activepython-3.6.0
  anaconda-1.4.0
  ...  
  anaconda3-5.2.0
  ironpython-dev
  ironpython-2.7.4
  ironpython-2.7.5
  ironpython-2.7.6.3
  ironpython-2.7.7
  jython-dev
  jython-2.5.0
  jython-2.5-dev
  jython-2.5.1
  jython-2.5.2
  jython-2.5.3
  jython-2.5.4-rc1
  jython-2.7.0
  jython-2.7.1
  micropython-dev
  micropython-1.9.3
  micropython-1.9.4
  miniconda-latest
  miniconda-2.2.2
  ...
  miniconda3-4.3.30
  pypy-c-jit-latest
  pypy-c-nojit-latest
  pypy-dev
  pypy-stm-2.3
  pypy-stm-2.5.1
  pypy-1.5-src
  pypy-1.5
  ...
  pypy3.5-6.0.0
  pyston-0.5.1
  pyston-0.6.0
  pyston-0.6.1
  stackless-dev
  stackless-2.7-dev
  stackless-2.7.2
  ...
  stackless-3.5.4
```

常见问题
----

用 pyenv 安装 Python 的时候可能会出现各种各样问题，例如缺少 zlib、缺少 ctypes 模块等等。对此 pyenv 也有专门一个[页面](https://github.com/pyenv/pyenv/wiki/common-build-problems)解决。对于我的 Ubuntu 18.04 虚拟机来说，安装以下一坨软件可以解决问题：

```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev libedit-dev
```

其他系统请查看 pyenv 的页面，如果有其它问题请自行搜索 [Stack Overflow](https://stackoverflow.com/)。

## virtualenv

为了pyenv，已经可以很方便地切换不同版本。但对于有代码洁癖的程序员来说，如果有不同的项目，每个项目都有不同的扩展类库，这些类库都统一安装在相应版本的python环境，会让他们感到很不舒服。他们更希望每个项目的环境都是独立的，纯粹的，干净的。

这么挑剔的要求，virtualenv表示实现起来毫无压力...

virtualenv就是python的虚拟化环境，用于管理python包，让系统环境干净

### 安装pyenv-virtualenv

- 下载代码

```javascript
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
```

- 配置自动激活

```javascript
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```

- 重新启动shell

```javascript
source ~/.zshrc
```

### pyenv-virtualenv的使用

创建3.6.2版本的虚拟环境

```javascript
pyenv virtualenv 3.6.2 py3.6.2 
pyenv versions  
  system
* 3.6.2 (set by /root/.pyenv/version)
  3.6.2/envs/py3.6.2
  py3.6.2
```

使3.6.2版本的虚拟环境生效

```javascript
pyenv activate py3.6.2
```

退出虚拟环境

```javascript
pyenv deactivate
```

删除虚拟环境，简单粗暴地将整个目录干掉即可

```javascript
rm -rf ~/.pyenv/versions/py3.6.2
```