#!/bin/bash

install() {
    read -n1 -rep "[warn] do you want to install archlinux? [y/n]: " answer
    [[ ! $answer =~ ^[Yy]$ ]] && return

    echo "[info] installing arch linux"

    # set keyboard
    loadkeys br-abnt2

    # connect to wifi
    iwctl
    [iwd] device list
    [iwd] station DEVICENAME scan
    [iwd] station DEVICENAME get-networks
    [iwd] station DEVICENAME connect NETWORKNAME

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
    sudo nmcli device wifi connect NETWORKNAME password NETWORKPASSWORD
}

setup() {
    read -n1 -rep "[warn] do you want to install pacman packages? [y/n]: " answer
    [[ ! $answer =~ ^[Yy]$ ]] && return

    echo "[info] installing pacman packages"

    sudo pacman -S --needed \
        alacritty antlr4 ascii asciinema base-devel bat bcc binaryen bind bison bpf bpftrace \
        btop clang cloc cmake colordiff copyq croc ctags curl delve direnv dmenu docker \
        docker-compose emscripten eza fd feh ffmpeg firefox fish fisher flameshot flex fuse2 \
        fzf gdb ghidra git github-cli go gperf grpc gzip htop hyperfine i3-wm i3lock i3status \
        imagemagick jq lldb llvm lsof man-pages memcached meson mitmproxy mkcert mpv mupdf nasm \
        ncdu neofetch neovim net-tools netcat nginx nmap nodejs npm openssh parallel pavucontrol \
        pcmanfm-gtk3 peek perf protobuf psensor pulseaudio python-pip qemu rabbitmq ranger re2c \
        redis redshift ripgrep rlwrap rsync rust-analyzer rustup shellcheck sqlite stow strace stylua \
        tig tldr tmux traceroute transmission-cli transmission-gtk tree ttf-hack ttf-hack-nerd udiskie \
        unclutter unrar unzip usbutils valgrind weechat wget xbindkeys xclip xdg-user-dirs xorg \
        xorg-xinit zig zip zls zstd
}

post_install() {
    read -n1 -rep "[warn] do you want to symlink dotfiles (this will overwrite your current config)? [y/n]: " answer
    [[ ! $answer =~ ^[Yy]$ ]] && return

    echo "[info] symlinking dotfiles"

    git clone https://github.com/ifdiego/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    stow .

    cp ~/.etc/10-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard.conf
    cp ~/.etc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

    chsh -s /usr/bin/fish

    sudo systemctl start docker.service
    sudo systemctl enable docker.service
    sudo usermod -aG docker "$USER"

    chmod 700 ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
    ssh -T git@github.com
    chmod 700 ~/.gnupg
    gpg --list-secret-keys --keyid-format=long

    rustup default stable
    xdg-user-dirs-update
}

echo "select item: "
options=("install archlinux" "setup pacman packages" "symlink dotfiles")

while true; do
    select option in "${options[@]}" exit; do
    case $REPLY in
        1) install; break;;
        2) setup; break;;
        3) post_install; break;;
        $((${#options[@]}+1))) echo "exiting"; break 2;;
        *) echo "[error] unknown answer"; break;
    esac
    done
done
