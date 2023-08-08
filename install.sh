#!/bin/bash

# archlinux installation guide script, not working
# set keyboard
loadkeys br-abnt2

# connect to wifi
iwctl
[iwd] device list
[iwd] station nomedodispositivo scan
[iwd] station nomedodispositivo get-networks
[iwd] station nomedodispositivo connect nomedarede

# system clock
timedatectl set-ntp true
timedatectl status

# partition disk
fdisk -l
fdisk /dev/sda
[fdisk] # create a gpt partition table
[fdisk] # add a partition
[fdisk] # 1 uefi size of +550M
[fdisk] # 2 swap size of +6G
[fdisk] # 3 system size of remaining space
[fdisk] # change a partition type
[fdisk] # 1 to uefi system
[fdisk] # 2 to swap system
[fdisk] # write the table to the disk

# make filesystem
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
lsblk

# base system
mount /dev/sda3 /mnt
pacstrap /mnt base linux linux-firmware

# generate filesystem
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
arch-chroot /mnt

# set timezone
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
date
pacman -S nano
nano /etc/locale.gen
# uncomment en_US.utf-8 and pt_BR.utf-8
locale-gen
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf

# hostname and hosts
nano /etc/hostname
# set archlinux for example
nano /etc/hosts
# 127.0.0.1   localhost
# ::1         localhost
# 127.0.1.1   archlinux.localdomain  archlinux

# create user
passwd
useradd -m diego
passwd diego
usermod -aG wheel,audio,video,optical,storage diego
pacman -S sudo
EDITOR=nano visudo
# uncomment %wheel ALL=(ALL:ALL) ALL

# grub install
pacman -S grub
pacman -S efibootmgr dosfstools os-prober mtools
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# network manager
pacman -S networkmanager
systemctl enable NetworkManager
exit

umount /mnt
umount -f /mnt
umount -l /mnt
reboot

# connect to wifi with network manager
nmcli device wifi list
sudo nmcli device wifi connect nomedarede password senhadarede

sudo pacman -S wget
wget https://raw.githubusercontent.com/ifdiego/dotfiles/.packages
sudo pacman -S --needed < .packages

git clone https://github.com/ifdiego/dotfiles.git ~/dotfiles
bash ~/dotfiles/setup.sh
