# Подготовка сервера под ключ

## Исходные данные

OS Version [2022-04-04-raspios-bullseye-arm64-lite](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2022-04-07/2022-04-04-raspios-bullseye-arm64-lite.img.xz)

## Установка OS

1. Скачать актуальную версию дистрибутива raspios-bullseye-arm64-lite https://downloads.raspberrypi.org/raspios_lite_arm64/images/
2. Скачать утилиту для записи образа https://sourceforge.net/projects/win32diskimager/
3. Записать через утилиту установочный образ дистрибутива ubuntu-server на устройство, которое будет использоваться как системный диск (microsd карта, usb ssd диск)
4. В разделе boot создать пустой файл с именем `ssh`
5. Подключить системный диск к raspberry pi, подать питание
6. Выбираем язык раскладки English (EU)
7. Ввести имя пользоваля и пароль

## Настройка OS

1. Заходим по ssh на сервер
2. Делаем:

       sudo apt update
       sudo apt upgrade
       sudo apt install mc git

3. Настраиваем пользователей

       sudo adduser ЛОГИН

   3.1 Добавляем в группу sudo

       sudo usermod -aG sudo ЛОГИН

   3.2 Создаем каталоги для хранения ssh ключей пользователей

       mkdir -p /home/ЛОГИН/.ssh

   3.3 Добавляем ssh ключи

       echo "Ваш Public RSA key" > /home/ЛОГИН/.ssh/authorized_keys

4. Генерируем ssh ключ на этом сервере для github https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

       ssh-keygen -t ed25519 -C "your_email@example.com"
5. Из файла $HOME/.ssh/id_ed25519.pub копируем строку, и в профиле github добавляем New SSH key https://github.com/settings/keys

6. Задаем имя и почту для работы с git

       git config --global user.name "username"
       git config --global user.email johndoe@example.com

7. Создаем в домашнем каталоге папку, копируем репозитории

       mkdir -p $HOME/github
       cd $HOME/github
       git clone git@github.com:chatlamin/serverhome.git

8. Подготавливаем профиль и OS для работы

       cd $HOME/github/serverhome/scripts/install/arm64/raspios_lite/ && ./install-tools.sh
       cd $HOME/github/serverhome/scripts/install/arm64/raspios_lite/ && ./install-docker.sh
       cd $HOME/github/serverhome/scripts/install/arm64/raspios_lite/ && ./install-docker-compose.sh

9. Меняем hostname

    Редактируем файл hostname

       sudo mcedit /etc/hostname
    Меняем текущий hostname на server1.serverhome.home
    <details>
    <summary>Полный конфиг</summary>

       server1.serverhome.home
    </details>

    Редактируем файл hosts

       sudo mcedit /etc/hosts
    Меняем текущий hostname на server1.serverhome.home

    <details>
    <summary>Полный конфиг</summary>
       127.0.0.1<----->localhost
       ::1<---><------>localhost ip6-localhost ip6-loopback
       ff02::1><------>ip6-allnodes
       ff02::2><------>ip6-allrouters

       127.0.1.1<-----><------>server1.serverhome.home
    </details>


10. Устанавливаем правильную timezone

        sudo timedatectl set-timezone Europe/Moscow

11. Настройка статического ip https://linuxhint.com/raspberry_pi_static_ip_setup/

        sudo mcedit /etc/dhcpcd.conf

    <details>
    <summary>Полный конфиг</summary>

        # A sample configuration for dhcpcd.
        # See dhcpcd.conf(5) for details.

        # Allow users of this group to interact with dhcpcd via the control socket.
        #controlgroup wheel

        # Inform the DHCP server of our hostname for DDNS.
        hostname

        # Use the hardware address of the interface for the Client ID.
        clientid
        # or
        # Use the same DUID + IAID as set in DHCPv6 for DHCPv4 ClientID as per RFC4361.
        # Some non-RFC compliant DHCP servers do not reply with this set.
        # In this case, comment out duid and enable clientid above.
        #duid

        # Persist interface configuration when dhcpcd exits.
        persistent

        # Rapid commit support.
        # Safe to enable by default because it requires the equivalent option set
        # on the server to actually work.
        option rapid_commit

        # A list of options to request from the DHCP server.
        option domain_name_servers, domain_name, domain_search, host_name
        option classless_static_routes
        # Respect the network MTU. This is applied to DHCP routes.
        option interface_mtu

        # Most distributions have NTP support.
        #option ntp_servers

        # A ServerID is required by RFC2131.
        require dhcp_server_identifier

        # Generate SLAAC address using the Hardware Address of the interface
        #slaac hwaddr
        # OR generate Stable Private IPv6 Addresses based from the DUID
        slaac private

        # Example static IP configuration:
        interface eth0
        static ip_address=192.168.88.2/24
        #static ip6_address=fd51:42f8:caae:d92e::ff/64
        static routers=192.168.88.1
        static domain_name_servers=172.17.0.1 8.8.8.8

        # It is possible to fall back to a static IP if DHCP fails:
        # define static profile
        #profile static_eth0
        #static ip_address=192.168.1.23/24
        #static routers=192.168.1.1
        #static domain_name_servers=192.168.1.1

        # fallback to static profile on eth0
        #interface eth0
        #fallback static_eth0

    </details>

12. Отключаем на хосте кэширующий dns systemd-resolved для работы dns сервера в докер-контейнере

        sudo systemctl disable systemd-resolved.service
        sudo systemctl stop systemd-resolved
        sudo rm /etc/resolv.conf

    <details>
    <summary>Возможные проблемы</summary>
    Докер сеть bridge может быть 172.18.0.0/16. Проверяем так:

        sudo docker network inspect bridge
    </details>

13. Перезагрузка

        sudo reboot

14. Перенастраиваем swap

        swapon --show
        swapoff /var/swap
        rm -f /var/swap
        fallocate -l 4G /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile

    Редактируем /etc/fstab

        sudo mcedit /etc/fstab

    Добавляем в конец

        /swapfile none swap sw 0 0

    Настройка частоты выгрузки данных из ОЗУ в swap

        sudo mcedit /etc/sysctl.conf

    Добавляем в конец

        vm.swappiness=10

    Настройка нагрузки кэш inode и dentry

        sudo mcedit /etc/sysctl.conf

    Добавляем в конец

        vm.vfs_cache_pressure=50
