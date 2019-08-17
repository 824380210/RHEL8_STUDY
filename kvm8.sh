virt-install --name rhel8-kvm --ram=16384 --vcpus=8  --disk path=/var/lib/libvirt/images/rhels8-kvm8.img,size=50,format=qcow2  \
--location="http://192.168.122.1/RHEL8/" \
--extra-args="ks=http://192.168.122.1/kvm.cfg"   \
--os-type=linux  \
--network bridge=virbr0,,mac=52:54:00:00:00:03 --graphics spice &
which virt-viewer &>/dev/null
if [ $? -ne 0 ];then
  yum install virt-viewer -y
fi
sleep 4
virt-viewer rhel8-kvm &
##
# other parameter example 
# --os-type=linux --os-variant=rhel8 
