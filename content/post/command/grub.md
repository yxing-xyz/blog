---
title: "Grub"
date: 2023-06-12T16:52:00+08:00
lastmod: 2023-06-12T16:52:00+08:00
draft: false
categories:
  - "命令行"
tags:
  - "命令行"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
1. Linux安装GRUB
2. efibootmgr调整UEFI启动顺序
3. GRUB手动引导Linux
4. GRUB手动引导Windows
<!--more-->

## grub
### linux安装grub
```bash
grub-install --target=x86_64-efi --boot-directory=/boot/ESP/EFI/ --efi-directory=/boot/ESP --bootloader-id=grub
grub-mkconfig -o /boot/ESP/EFI/grub/grub.cfg
```
### efibootmgr调整UEFI启动顺序
```bash
efibootmgr -o 0,1,2
```

### GRUB手动引导linux
```bash
# 查看uuid
ls (hd0,gpt3)
# 设置root加载linux
linux (hd0,gpt3)/boot/vmlinuz-6.1.12-gentoo-dist root=UUID=cef878343-3434-3fdd-2323343
# 加载initrd
initrd (hd0,gpt3)/boot/initramfs-6.1.12-gentoo-dist.img
# 启动
boot
```
### GRUB手动引导Window
```bash
menuentry "Windows 10" {
    insmod part_msdos
    insmod ntfs
    set root=(hd0,gpt1)
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    boot
}
```