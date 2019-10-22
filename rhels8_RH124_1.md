# RHELS8.0 RH124 红帽系统管理一


### 针对没有linux系统管理经验的IT专业人员，包括系统的安装，网络连接建立，管理物理存储，以及管理基本安全等

## 网络结构
```
bastion	英[ˈbæstiən] 美[ˈbæstʃən] n.	堡垒; 捍卫者; (军事) 堡垒; 防御工事;
lab.example.com 是域名，
堡垒机：bastion.lab.exampel.com. 172.25.250.254 网关，作为连接到教室网络和学员网络环境的网关
学员机：物理机装GUI OS，并虚拟了两个虚拟机，在 172.25.250.9/10/11网络，实现网络间的通信，服务提供等实验
```

### 本课程忽略 cockpit 这个工具
```
systemctl enable --now cockpit.socket

```

### 补充知识： 虚拟机的快照使用，如何恢复等，对应 rht-vmctl start/view/reset xxxx
```

```

### 输入法及语言选择方法
```
将下面内容放在用户的~/.bashrc中，实现用户ssh登录与gnome登录的语言一样的
i=$(grep  'Language=' /var/lib/AccountsService/users/${USER} | sed 's/Language//')
if [ "$i" != "" ] ;then
   export Lang=$i
fi
#在gnome中，Activities->九宫格->Settings->Regopm & Language ()


# 系统范围内的语言设置文件是/etc/locale.conf
[root@peter ~]# cat /etc/locale.conf
LANG="en_US.UTF-8"
[root@peter ~]# localectl set-locale -h
localectl [OPTIONS...] COMMAND ...

Query or change system locale and keyboard settings.

  -h --help                Show this help
     --version             Show package version
     --no-pager            Do not pipe output into a pager
     --no-ask-password     Do not prompt for password
  -H --host=[USER@]HOST    Operate on remote host
  -M --machine=CONTAINER   Operate on local container
     --no-convert          Don't convert keyboard mappings

Commands:
  status                   Show current locale settings
  set-locale LOCALE...     Set system locale
  list-locales             Show known locales
  set-keymap MAP [MAP]     Set console and X11 keyboard mappings
  list-keymaps             Show known virtual console keyboard mappings


```

### 语言包
```
yum list langpacks-*   # 显示已安装和可以安装的语言包
[root@peter ~]# yum list langpacks-*
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Last metadata expiration check: 0:01:47 ago on Mon 21 Oct 2019 05:11:08 AM EDT.
Installed Packages
langpacks-en.noarch                                                                    1.0-12.el8                                                                 @AppStream
Available Packages
langpacks-af.noarch                                                                    1.0-12.el8                                                                 AppStream
langpacks-am.noarch                                                                    1.0-12.el8                                                                 AppStream
langpacks-ar.noarch                                                                    1.0-12.el8                                                                 AppStream

yum repoquery --whatsupplements  # 查语言包中有那些RPM包

[root@peter ~]# yum repoquery --whatsupplements langpacks-zh_CN
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
AppStream                                                                                                                                   3.1 MB/s | 3.2 kB     00:00
BaseOS                                                                                                                                      2.7 MB/s | 2.7 kB     00:00
glibc-langpack-zh-0:2.28-42.el8.x86_64
libreoffice-langpack-zh-Hans-1:6.0.6.1-13.el8.x86_64
[root@peter ~]#



yum info langpacks-SUFFIX  # 显示一些语言包信息

ot@peter ~]# yum info langpacks-en
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Installed Packages
Name         : langpacks-en
Version      : 1.0
Release      : 12.el8
Arch         : noarch
Size         : 400
Source       : langpacks-1.0-12.el8.src.rpm
Repo         : @System
From repo    : AppStream
Summary      : English langpacks meta-package
License      : GPLv2+
Description  : This package provides English langpacks meta-package.

[root@peter ~]# yum info langpacks-zh_CN
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Available Packages
Name         : langpacks-zh_CN
Version      : 1.0
Release      : 12.el8
Arch         : noarch
Size         : 9.6 k
Source       : langpacks-1.0-12.el8.src.rpm
Repo         : AppStream
Summary      : Simplified Chinese langpacks meta-package
License      : GPLv2+
Description  : This package provides Simplified Chinese langpacks meta-package

```

### 第一章 红帽企业Linux入门 
```
开源：开放源代码，自由共享给他人使用，理解系统软件的工作，更容易进行改进，加快创新速度
提供强大的可以脚本化的命令行接口
模块化的操作系统，按需要安装和删除组件
开源软件是指任何人都可以使用，研究，修改和共享其源代码的软件

开源好处：
	控制：查看代码用途，并进行更改以作出改进
	培训: 从实际代码出发，并开发出更实用的应用
	安全性：检查敏感代码，并加以修复，无论原始作者是否提供帮助
	稳定性：代码可以在开发者或者分发者不在后继续保留

红帽的收费是基于订阅的分发模型：收费原因是为支持维护，更新，安全补丁，访问红帽客户门户上的知识库，认证等支付的费用，是客户为长期支持，专业知识，承诺以及所需要的帮助付费。注意，开源软件不需要许可费

linux发行版是一种可安装的操作系统，由内核，用户程序和库构成

红帽为开源项目提供支持并贡献代码，赞助项目软件并将它集成到社区驱动的发行版中，同时使软件成熟成为稳定版，以作为受支持企业就绪型产品来提供它

```

### 第二章 红帽企业Linux 命令行
```
1: shell中的 # 与 $ 的区别
2：shell中三个要素，命令，选项，参数
	命令是要运行的程序 
	选项用于调整命令的行为及其作用，通常是用 - 或者 -- 来指定选项
	参数是可选的，可以是一个或者多个
	usermod -L user-1 ：锁定用户
3：锁定的用户在/etc/shadow中密码字符串前有一个！代表锁定

[root@peter ~]# cat /etc/shadow | grep mgt
mgt:!$6$QWZC4WQnl6z5wKCx$QnCFQnPp1J.V1BUvFiFzT8csTTh4O1sqqV0Bu7BABFutfip/Qpmp4ug12PbTEMPgMsKS0k3ezBdOeW5c5gwUC0::0:99999:7:::
[root@peter ~]# usermod -U mgt
[root@peter ~]# cat /etc/shadow | grep mgt
mgt:$6$QWZC4WQnl6z5wKCx$QnCFQnPp1J.V1BUvFiFzT8csTTh4O1sqqV0Bu7BABFutfip/Qpmp4ug12PbTEMPgMsKS0k3ezBdOeW5c5gwUC0::0:99999:7:::
[root@peter ~]#

4： 在外连接系统中，为了安全，建议使用SSH的公钥进行认证，这样保证安全性

5： gnome 锁屏， super + L super键就是 win键 ，按下win 	键会直接弹出Activities栏的仪表栏（又叫停靠台） 

6： 消息托盘，是位于居中上方的时间栏，按super+M 来弹出或者关闭

7： ALT + F2来弹出组合键

8： 密码修改的三种方法：
	1：passwd username
	2: echo xxxx|passwd  --stdin username
	3: (echo xxxx ;echo xxxx)|passwd username

9:   date命令讲解，man date ,date +%R,date +%F

10:  file /etc/passwd ; file /bin/passwd 

11:  more / less/ head/tail /cat 

12； wc  / wc -l /wc -c /wc -w

13:  tab 补全，如usreadd 连接两次tab

14： 用"\"来续长命令行

15： 命令行历史 history ,用感吧号加命令行号重复执行命令，用!string执行最近执行命令，用ctrl +r来查找历史命令

16：命令行快捷键编辑
	1： ctrl+A /ctrl +e 跳到命令行的行首，行尾
	2： ctrl+U /ctrl +K 清除光标到命令行首/行尾的内容
	3： ctrl + R 在命令行历史中查内容
	4： ctrl+ 前后箭头，用于跳到前一个字头/后一个字尾
	5： Esc+. 复制前一个命令的最后一个参数到当前命令


```

###
```



```

###
```



```


###
```



```

###
```



```





