#!bin/bash

# [debian 参考](https://www.debian.org/releases/bullseye/amd64/apds03.ja.html)
# ホスト側でdebootstrapをインストールしておく。

# dnfはrhel系以外ならarch系にcommunityでインストールできる。

mkdir /mnt/fedora
mount /dev/sdb4 /mnt/fedora

version=35
dnf --installroot=/mnt/fedora -releasever=$version centos-stream-release systemd

# /etc/fstabはdebianは手動で作る方針なので、マルチブートならコピーして流用が簡単
# マウントするデバイスは帰ること。
# cp /etc/fstab /mnt/debian/etc/

# chroot
mount --types proc /proc /mnt/fedora/proc
mount --rbind /sys /mnt/fedora/sys
mount --make-rslave /mnt/fedora/sys
mount --rbind /dev /mnt/fedora/dev
mount --make-rslave /mnt/fedora/dev
mount --bind /run /mnt/fedora/run
mount --make-slave /mnt/fedora/run
