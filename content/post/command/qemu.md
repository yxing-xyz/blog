---
title: "Qemu"
date: 2023-06-12T16:52:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "command"
tags:
  - "command"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---

### 创建qcow2磁盘文件
```bash
qemu-img create -f qcow2 gentoo.qcow2 100G
# 复制一块qcow2
qemu-img create -f qcow2 -F qcow2 -b a.qcow2 b.qcow2
```
### qemu snapshot
```bash
### 快照
#### 创建快照
qemu-img snapshot -c 2023-03-01 linux.qcow2
#### 查看快照
qemu-img snapshot -l linux.qcow2
#### 删除快照
qemu-img snapshot -d 2023-03-01 ./linux.qcow2
#### 使用快照
qemu-img snapshot -a 2023-03-01 linux.qcow2
```


## Qemu启动
### docker的qemu启动命令
```bash
/opt/homebrew/bin/qemu-system-aarch64
-accel hvf
-cpu host
-machine virt,highmem=off
-m 16384
-smp 8
-kernel /Applications/Docker.app/Contents/Resources/linuxkit/kernel
-append page_poison=1 vsyscall=emulate panic=1 nospec_store_bypass_disable noibrs noibpb no_stf_barrier mitigations=off linuxkit.unified_cgroup_hierarchy=1    vpnkit.connect=tcp+bootstrap+client://192.168.65.2:54760/a8f36b5c3f2bb8125044cbdce643cae23bf73557ebc1a3a95ffd87993e1d8516 vpnkit.disable=osxfs-data console=ttyAMA0
-initrd /Applications/Docker.app/Contents/Resources/linuxkit/initrd.img
-serial pipe:/var/folders/hd/sgm8y5kj4g9740whp7b8w37m0000gn/T/qemu-console1934410198/fifo
-drive if=none,file=/Users/x/Library/Containers/com.docker.docker/Data/vms/0/data/Docker.raw,format=raw,id=hd0
-device virtio-blk-pci,drive=hd0,serial=dummyserial -netdev socket,id=net1,fd=3 -device virtio-net-device,netdev=net1,mac=02:50:00:00:00:01
-vga none
-nographic
-monitor none
```
### podman的qemu启动命令
```bash
qemu-system-aarch64 -m 16384 -smp 8 \
-fw_cfg name=opt/com.coreos/config,file=/Users/x/.config/containers/podman/machine/qemu/podman-machine-default.ign \
-qmp unix:/var/folders/hd/sgm8y5kj4g9740whp7b8w37m0000gn/T/podman/qmp_podman-machine-default.sock,server=on,wait=off \
-netdev socket,id=vlan,fd=3 \
-device virtio-net-pci,netdev=vlan,mac=5a:94:ef:e4:0c:ee \
-device virtio-serial \
-chardev socket,path=/var/folders/hd/sgm8y5kj4g9740whp7b8w37m0000gn/T/podman/podman-machine-default_ready.sock,server=on,wait=off,id=apodman-machine-default_ready \
-device virtserialport,chardev=apodman-machine-default_ready,name=org.fedoraproject.port.0 \
-pidfile /var/folders/hd/sgm8y5kj4g9740whp7b8w37m0000gn/T/podman/podman-machine-default_vm.pid \
-accel hvf -accel tcg -cpu host -M virt,highmem=on \
-drive file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
-drive file=/Users/x/.local/share/containers/podman/machine/qemu/podman-machine-default_ovmf_vars.fd,if=pflash,format=raw \
-virtfs local,path=/Users,mount_tag=vol0,security_model=none \
-virtfs local,path=/private,mount_tag=vol1,security_model=none \
-virtfs local,path=/var/folders,mount_tag=vol2,security_model=none \
-drive if=virtio,file=/Users/x/.local/share/containers/podman/machine/qemu/podman-machine-default_fedora-coreos-37.20230322.2.0-qemu.aarch64.qcow2
```
### 我的Qemu启动命令
```bash
### mac m1 qemu cd启动
# 桥接网卡参数 -nic vmnet-bridged,ifname=en0 \
# -bios /opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-aarch64-code.fd \
qemu-system-aarch64 \
    -machine virt \
    -accel hvf \
    -accel tcg \
    -boot d \
    -cpu host \
    -smp 8 \
    -m 16384 \
    -drive if=pflash,format=raw,file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-aarch64-code.fd \
    -drive if=pflash,format=raw,file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-arm-vars.fd \
    -drive format=qcow2,file=/Users/x/workspace/demo/gentoo/linux.qcow2 \
    -cdrom  /Users/x/workspace/demo/gentoo/install-arm64-minimal-20230226T234708Z.iso \
    -device virtio-gpu \
    -device usb-ehci \
    -device usb-kbd \
    -device usb-mouse \
    -nic user,hostfwd=tcp::22-:22

### mac m1 qemu图形化启动
qemu-system-aarch64 \
    -machine virt \
    -accel hvf \
    -accel tcg \
    -boot d \
    -cpu host \
    -smp 8 \
    -m 16384 \
    -drive if=pflash,format=raw,file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-aarch64-code.fd \
    -drive if=pflash,format=raw,file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-arm-vars.fd \
    -drive format=qcow2,file=/Users/x/workspace/demo/gentoo/linux.qcow2 \
    -device virtio-gpu \
    -device usb-ehci \
    -device usb-kbd \
    -device usb-mouse \
    -nic user,hostfwd=tcp::22-:22

### mac m1 qemu禁用图形化和串口模拟器
qemu-system-aarch64 \
    -machine virt \
    -accel hvf \
    -accel tcg \
    -boot d \
    -cpu host \
    -smp 8 \
    -m 16384 \
    -drive if=pflash,format=raw,file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-aarch64-code.fd \
    -drive if=pflash,format=raw,file=/opt/homebrew/Cellar/qemu/7.2.1/share/qemu/edk2-arm-vars.fd \
    -drive format=qcow2,file=/Users/x/workspace/demo/gentoo/linux.qcow2 \
    -device virtio-gpu \
    -device usb-ehci \
    -device usb-kbd \
    -device usb-mouse \
    -nic user,hostfwd=tcp::22-:22 \
    -display non
```
### qemu启动内核
编写init程序
> gcc -o init init.c -static
```c
#include<unistd.h>
#include<stdio.h>
#include<linux/reboot.h>
#include<sys/reboot.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    printf("this is the init program !\n");
    sleep(60);
    reboot(LINUX_REBOOT_CMD_RESTART);
    return 0;
}
```
```bash
# 制作initramfs
./make_initramfs.sh rootfs initramfs.cpio.gz
# 解压initramfs， initramfs可能被压缩，需要提前解压缩一次
cpio -idmv < ./initramfs-6.1.12-gentoo.imgv

qemu-system-x86_64 \
-smp 1 \
-m 512 \
-kernel bzImage \
-append "root=/dev/ram0 rootfstype=ramfs rw init=/init" \
-initrd initramfs.cpio.gz
```
