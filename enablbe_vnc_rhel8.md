# enable vnc in rhel8 system  
``` 
-- Unit vncserver@:1.service has begun starting up.
Oct 18 04:21:02 peter.cluster vncserver[32308]: vncserver: The HOME environment variable is not set.
Oct 18 04:21:02 peter.cluster systemd[1]: vncserver@:1.service: Control process exited, code=exited status=2
Oct 18 04:21:02 peter.cluster systemd[1]: vncserver@:1.service: Failed with result 'exit-code'.
Oct 18 04:21:02 peter.cluster systemd[1]: Failed to start Remote desktop service (VNC).
-- Subject: Unit vncserver@:1.service has failed
-- Defined-By: systemd
-- Support: https://access.redhat.com/support

```

### 配置文件重要更新，重点在： 51-53，56 这几行的修改
```
[root@peter ~]# cat /usr/lib/systemd/system/vncserver@:1.service
# The vncserver service unit file
#
# Quick HowTo: As the User wanting to have this functionality
#
# 1. Copy this file to ~/.config/systemd/user/ (Optional, in case default settings are not suitable)
#
#   $ mkdir -p ~/.config/systemd/user
#   $ cp /usr/lib/systemd/user/vncserver@.service ~/.config/systemd/user/
#
# 2. Reload user's systemd
#
#    $ systemctl --user daemon-reload
#
# 3. Start the service immediately and enable it at boot
#
#    $ systemctl --user enable vncserver@:<display>.service --now
#
# 4. Enable lingering
#
#    $ loginctl enable-linger
#
# DO NOT RUN THIS SERVICE if your local area network is
# untrusted!  For a secure way of using VNC, you should
# limit connections to the local host and then tunnel from
# the machine you want to view VNC on (host A) to the machine
# whose VNC output you want to view (host B)
#
# [user@hostA ~]$ ssh -v -C -L 590N:localhost:590M hostB
#
# this will open a connection on port 590N of your hostA to hostB's port 590M
# (in fact, it ssh-connects to hostB and then connects to localhost (on hostB).
# See the ssh man page for details on port forwarding)
#
# You can then point a VNC client on hostA at vncdisplay N of localhost and with
# the help of ssh, you end up seeing what hostB makes available on port 590M
#
# Use "-nolisten tcp" to prevent X connections to your VNC server via TCP.
#
# Use "-localhost" to prevent remote VNC clients connecting except when
# doing so through a secure tunnel.  See the "-via" option in the
# `man vncviewer' manual page.


[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
WorkingDirectory=/root
User=root
Group=root

ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver %i  -geometry 1300x800 -AlwaysShared
ExecStop=/usr/bin/vncserver -kill %i

Restart=on-success
RestartSec=15

[Install]
WantedBy=default.target
[root@peter ~]#
```

### 设置vnc密码
```
[root@peter ~]#  (echo passw0rd ;echo passw0rd;echo n )|vncpasswd
Would you like to enter a view-only password (y/n)? A view-only password is not used
Password:Verify:[root@peter ~]#
```
### 启用服务，检查状态
```
[root@peter ~]# systemctl enable vncserver@\:1.service
Created symlink /etc/systemd/system/default.target.wants/vncserver@:1.service → /usr/lib/systemd/system/vncserver@:1.service.
[root@peter ~]# systemctl start vncserver@\:1.service
[root@peter ~]# ps aux |grep vnc
root     32475  1.5  0.0 1401160 57372 ?       Sl   04:26   0:00 /usr/bin/Xvnc :1 -auth /root/.Xauthority -desktop peter.cluster:1 (root) -fp catalogue:/etc/X11/fontpath.d -geometry 1300x800 -pn -rfbauth /root/.vnc/passwd -rfbport 5901 -rfbwait 30000 -AlwaysShared
root     32496  0.0  0.0  12700  3088 ?        S    04:26   0:00 /bin/sh /root/.vnc/xstartup
root     33084  0.0  0.0  12112  1112 pts/0    S+   04:27   0:00 grep --color=auto vnc
[root@peter ~]#  netstat -tunlp | grep 5901
tcp        0      0 0.0.0.0:5901            0.0.0.0:*               LISTEN      32475/Xvnc
tcp6       0      0 :::5901                 :::*                    LISTEN      32475/Xvnc

```

###  处理防火墙问题
```
[root@peter ~]# firewall-cmd --permanent --add-port=5901/tcp
success
[root@peter ~]#  firewall-cmd --reload
success
```
