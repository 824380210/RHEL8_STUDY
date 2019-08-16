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
WILL UPDATE LATER 



```
### EXAMPLE IN KICKSTART
```


WILL UPDATE LATER 

```
