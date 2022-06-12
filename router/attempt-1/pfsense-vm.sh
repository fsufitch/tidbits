#!/bin/bash
set -ex

# https://linux-tips.com/t/booting-from-an-iso-image-using-qemu/136

### Setup:
# qemu-img create -f qcow2 disk.qcow2 10G
# qemu-system-x86_64 -enable-kvm -hda disk.qcow2 -boot d -cdrom pfSense-CE-2.6.0-RELEASE-amd64.iso -m 4G


# Network config:
# https://wiki.archlinux.org/title/network_bridge

# nmcli c down "Wired Connection 2"


#nmcli c add type bridge ifname br-wan stp no con-name 'WAN: Bridge'
#nmcli c add type bridge-slave ifname enp1s0f0 master br-wan con-name 'WAN: Ethernet (bridge slave)'
#nmcli c add type tun mode tap ifname tun-wan con-name 'WAN: TAP'
#nmcli c add type bridge-slave ifname tun-wan master br-wan con-name 'WAN: TAP (bridge slave)'
#nmcli c up 'WAN: Bridge'
#
#nmcli c add type bridge ifname br-lan stp no con-name 'LAN: Bridge'
#nmcli c add type bridge-slave ifname enp1s0f1 master br-lan con-name 'LAN: Ethernet (bridge slave)'
#nmcli c add type tun mode tap ifname tun-lan con-name 'LAN: TAP'
#nmcli c add type bridge-slave ifname tun-lan master br-lan con-name 'LAN: TAP (bridge slave)'
#nmcli c up 'LAN: Bridge'
#

# To clear everything:

#nmcli c delete 'WAN: Bridge'
#nmcli c delete 'WAN: Ethernet (bridge slave)'
#nmcli c delete 'WAN: TAP'
#nmcli c delete 'WAN: TAP (bridge slave)'
#nmcli c delete 'LAN: Bridge'
#nmcli c delete 'LAN: Ethernet (bridge slave)'
#nmcli c delete 'LAN: TAP'
#nmcli c delete 'LAN: TAP (bridge slave)'
#

# https://www.mankier.com/1/qemu#Options-Network_options

qemu-system-x86_64 \
    -enable-kvm \
    -curses \
    -smp 4 \
    -m 4G \
    -hda disk.qcow2 \
    -netdev tap,id=n1,br=br-wan,ifname=tun-wan \
    -device e1000,netdev=n1 \
    -netdev tap,id=n2,br=br-lan,ifname=tun-lan \
    -device e1000,netdev=n2


#    -nic user,model=e1000,id=nuser,hostfwd=tcp:127.0.0.1:80-:80


