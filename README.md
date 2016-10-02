fkol-k4.ubuntu.extras
=====================

###Scripts and files i use for managing my Ubuntu Linux installation.

This set of files and scripts is for managing and updating an Ubuntu Linux installation, installed inside a subvolume of a **BTRFS** partition.

This type of installation provides an easy way to always have a complete backup of our installed system, so that it is very easy to restore the system to a previous state if something goes wrong.
Of course, the files can also be used in a regular ext4 installation amd simply not use the extra capabilities for the BTRFS filesystem.

In case that the system is dual-boot (or even multi-boot such mine), the updates script also provides an easy way to transfer a GRUB2 entry to every other distribution of the computer by creating an entry file in every **/etc/grub.d/** directory.

This is useful because GRUB2's os-prober subsystem cannot detect a Linux installation installed inside a BTRFS subvolume.

Clone this repo by entering:
`git clone https://github.com/fkol-k4/fkol-k4.ubuntu.extras.git`

**_WARNING:_**
**This repository contains not only the update and subvolume handling script, but also various other things that i use, such as other scripts, custom dotfiles etc.**
If you don't need all these and just want the update and subvolume handling script, then all you have to copy from this repository to your system are the following files: 

    /etc/systemd/system/fkol-k4.grub_transfer.service
    /usr/local/bin/fkol-k4.grub_transfer
    /home/fkol-k4/.local/share/applications/org.fkol-k4.ubuntu_updates.desktop
    /usr/share/icons/fkol-k4/fkol-k4.donkey.grey.square.svg
    /usr/local/bin/fkol-k4.ubuntu_updates

_Make sure to keep the same path scheme so that the update scrpit can be launched via its launcher_.

We are using `systemd` for the GRUB transfer service, so you need to enable it by entering:
`sudo systemctl enable fkol-k4.grub_transfer.service`

There are some variables that you have to define in the following files before copying them to your system.
These are located on the beginning of the file and there are comments that guide to on how to define them.
