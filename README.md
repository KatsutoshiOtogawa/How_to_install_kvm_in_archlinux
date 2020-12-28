# How_to_install_kvm_in_archlinux

```shell
# experiment in archlinux at 20201227

```

```shell
# oracle database launch and, be available.

# these command is operationing in oracle user. oracle is OS user.oracle user belong to dbaoper.
echo "startup;" | sqlplus / as sysdba
launchctl start
```
# example script
this project has Vagrantfile.
```shell
vagrant up
```
oracle-fedora environment is being launch.

# install sample schemas

```shell
# change user and read .bash_profile.
sudo su
source ~/.bash_profile

# execute bash function.
enable_sampleschema

# if you uninstall schema, execute below function
disable_sampleschema
```

# 
```shell
virsh undefine vm_name --wipe-storage --remove-all-storage
```

# you find bug and fix
```shell
pacman -S --noconfirm asp
```
# if you want to create vagrant box from vagrant file.

```shell
# stop vagrant environment
vagrant halt

# search virtualbox environment.
ls -1 ~/VirtualBox\ VMs/

# packaging your vagrant virtualbox environment. 
vagrant package --base <yourvirtualbox_environment_name> --output oraclelinux8-oracle-xe-18.box

# add box
vagrant box add localhost/oraclelinux8-oracle-xe-18 oraclelinux8-oracle-xe-18.box
```

# reference

[archlinux pacman compare other distro](https://wiki.archlinux.org/index.php/Pacman/Rosetta)
[archwiki:kvm](https://wiki.archlinux.org/index.php/KVM)

[nested-virtualization](https://blog.amedama.jp/entry/virtualbox-nested-virtualization)
[libvirt kvm](https://densan-hoshigumi.com/server/centos8-kvm-install)
[archwiki:libvirt](https://wiki.archlinux.org/index.php/libvirt)
[libvirt networks](https://kernhack.hatenablog.com/entry/2014/05/12/221554)
[libvirt:kickstart](https://qiita.com/slotport/items/6af9efbc5a20a94f51b6)
[virsh](https://qiita.com/TsutomuNakamura/items/22d9d2629a8eb9360865)
[debian document:preseed.cfg](https://www.debian.org/releases/jessie/mips/apbs02.html.en)
[ubuntu document:preseed.cfg](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt)
[tokyo debian study group](https://tokyodebian-team.pages.debian.net/pdf2016/debianmeetingresume201610-presentation-sugimoto.pdf)