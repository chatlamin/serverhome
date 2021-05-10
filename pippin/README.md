# disable avahi

https://www.spaetzle.info/raspberry-server/#Stop_the_avahi_service

    sudo systemctl stop avahi-daemon.service
    sudo systemctl stop avahi-daemon.socket
    sudo systemctl disable avahi-daemon.service
    sudo systemctl disable avahi-daemon.socket

# static ip

https://raspberrypi.stackexchange.com/a/106914

    sudo systemctl stop dhcpcd
    sudo systemctl disable dhcpcd
    sudo touch /etc/network/interfaces.d/eth0
    sudo mcedit /etc/network/interfaces.d/eth0
    auto eth0
    allow-hotplug eth0
    iface eth0 inet static
    address xxx.xxx.xxx.xxx
    netmask 255.xxx.xxx.xxx
    gateway xxx.xxx.xxx.xxx
    dns-nameservers xxx.xxx.xxx.xxx

# disable systemd-resolved

    sudo systemctl disable systemd-resolved.service
    sudo systemctl stop systemd-resolved
    sudo rm /etc/resolv.conf
    sudo bash -c 'echo nameserver 172.17.0.1 > /etc/resolv.conf'
    sudo bash -c 'echo nameserver xxx.xxx.xxx.xxx >> /etc/resolv.conf'