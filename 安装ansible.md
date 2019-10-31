# 安装rhels8.0 / CentOS 8.0 Ansible的参考命令，可以直接放在脚本中执行，保证互联网可用和 DVD 的源可用 
```
dnf -y install python3-pip
pip3 install --upgrade pip -i https://mirrors.aliyun.com/pypi/simple/
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install  --enablerepo epel-playground  ansible -y
ansible --version

```
# 参考的 DVD 源 
```
[root@mgt ~]# cat /etc/yum.repos.d/http.repo
[BaseOS]
name=BaseOS
baseurl=http://192.168.122.1/rhels8.0/x86_64/BaseOS
enabled=1
gpgcheck=0
[AppStream]
name=AppStrem
baseurl=http://192.168.122.1/rhels8.0/x86_64/AppStream
enabled=1
gpgcheck=0


```
