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



```

### 补充知识： 虚拟机的快照使用，如何恢复等，对应 rht-vmctl start/view/reset xxxx
```




```

### 输入法及语言选择方法
```



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


###
```



```

###
```



```





