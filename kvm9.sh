virt-install --name rhel9-kvm --ram=16384 --vcpus=8  --disk path=/var/lib/libvirt/images/rhels8-kvm9.img,size=50,format=qcow2  \
--location="http://192.168.122.1/RHEL8/" \
--extra-args="ks=http://192.168.122.1/kvm9.cfg"   \
--os-type=linux  \
--network bridge=virbr0,,mac=52:54:00:00:00:09 --graphics spice &
which virt-viewer &>/dev/null
if [ $? -ne 0 ];then
  yum install virt-viewer -y
fi
virt-viewer rhel9-kvm &
##
# other parameter example 
# --os-type=linux --os-variant=rhel8 
echo -e "=================END========================"
