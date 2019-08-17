# RHLE8 REPOSITORY EXAMPLE

### LOCLA REPOSITORY 
```

[root@localhost ~]# cat /etc/yum.repos.d/local.repo
[BaseOS]
name=BaseOS
baseurl=file:///run/media/root/RHEL-8-0-0-BaseOS-x86_64/BaseOS
enabled=1
gpgcheck=0
[AppStream]
name=AppStrem
baseurl=file:///run/media/root/RHEL-8-0-0-BaseOS-x86_64/AppStream
enabled=1
gpgcheck=0
[root@localhost ~]# mount | grep RHEL-8-0-0-BaseOS-x86_64
/dev/sr0 on /run/media/root/RHEL-8-0-0-BaseOS-x86_64 type iso9660 (ro,nosuid,nodev,relatime,nojoliet,check=s,map=n,blocksize=2048,uid=0,gid=0,dmode=500,fmode=400,uhelper=udisks2)





```
### HTTP REPOSITORY 
```
[root@localhost ~]# cat /etc/yum.repos.d/http.repo
[BaseOS]
name=BaseOS
baseurl=http://192.168.122.1/RHEL8/BaseOS
enabled=1
gpgcheck=0
[AppStream]
name=AppStrem
baseurl=http://192.168.122.1/RHEL8/AppStream
enabled=1
gpgcheck=0
[root@localhost ~]#
 
[root@mgt ~]# mount | grep RHEL8
/var/www/html/rhel-8.0-x86_64-dvd.iso on /var/www/html/RHEL8 type iso9660 (ro,relatime)
[root@mgt ~]# ls /var/www/html/RHEL8/
AppStream  BaseOS  EFI  EULA  extra_files.json  GPL  images  isolinux  media.repo  RPM-GPG-KEY-redhat-beta  RPM-GPG-KEY-redhat-release  TRANS.TBL
[root@mgt ~]#


```
### EXAMPLE IN KICKSTART
```
repo --name="AppStream" --baseurl=http://192.168.122.1/RHEL8/AppStream
repo --name="BaseOS" --baseurl=http://192.168.122.1/RHEL8/BaseOS


```
