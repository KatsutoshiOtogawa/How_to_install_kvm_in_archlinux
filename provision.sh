
pacman -Syu --noconfirm

pacman -S --noconfirm which

# check cpu can use kvm.
if ! lscpu | grep -q Virtualization; then
    echo this system has cpu can\'t use Virtualization!
    exit 0
fi

# load kernel module for using kvm.
modprobe -r kvm_intel
modprobe kvm_intel nested=1

# permanently set kvm_intel nested
echo '# need to use kvm in vagrant ' >> /etc/modprobe.d/kvm_intel.conf
echo options kvm_intel nested=1 >> /etc/modprobe.d/kvm_intel.conf
echo '' >> /etc/modprobe.d/kvm_intel.conf

# install libvirt environement
pacman -S --noconfirm community/libvirt community/virt-install extra/qemu-headless

# Depends On      : libosinfo  libvirt-python  python-gobject  python-requests
# vi is needed `virsh edit`. cpio is needed ‘virt-install --initrd-inject` initrd.gz
pacman -S --noconfirm extra/cpio core/vi

# install for editting libvirt configfile from scripting
pacman -S --noconfirm community/xmlstarlet

# need to config libvirt networks and firewall.
pacman -S --noconfirm extra/ebtables extra/dnsmasq

## you want to use WebUI
# pacman -S --noconfirm community/cockpit community/cockpit-machines
# 

virsh net-autostart default enable
virsh net-start default

# check libvirt network settings.
virsh net-list --all

# check *os-variant* `osinfo-query os`
# see document [debian system requirement](https://www.debian.org/releases/stable/amd64/ch02s05.en.html)

vm_name=hello_virsh
vm_disksize=5
vm_memory=1024
virt-install \
--name $vm_name \
--hvm \
--os-type linux \
--os-variant ubuntu20.04 \
--vcpus 1 \
--ram $vm_memory \
--disk path=/var/lib/libvirt/images/$vm_name.img,format=qcow2,size=$vm_disksize \
--noautoconsole \
--location http://ftp.jaist.ac.jp/pub/Linux/ubuntu/dists/focal/main/installer-amd64 \
--initrd-inject=/vagrant/preseed.cfg \
--extra-args=console=ttyS0,115200n8 \
--virt-type kvm


# --filesystem
# edit 
# --cdrom /tmp/debian-10.7.0-amd64-netinst.iso \
xmlstarlet ed -L -u "///cpu/@mode" -v 'host-passthrough' \
                 -u "///cpu/@check" -v 'partial' \
                 /etc/libvirt/qemu/debian10.xml


virsh undefine debian10 --remove-all-storage
# --connect=qemu:///system \

## if check these command and 
# zgrep CONFIG_KVM /proc/config.gz
# lsmod | grep kvm
# zgrep VIRTIO /proc/config.gz
## list you can load kernel modules
# find /lib/modules/$(uname -r) -type f -name *.ko.*


