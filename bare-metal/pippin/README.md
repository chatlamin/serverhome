# Подготовка сервера под ключ

## Исходные данные

| Характеристики |  | Кол-во |
| --- | --- | --- |
| Производитель | Raspberry Pi |  |
| Модель | Raspberry Pi 4 Model B |  |
| Материнская плата | - |  |
| Монтажная единица | non-rack |  |
| Серийный номер | - |  |
| Ярлык | pippin.serverhome.home |  |
| Hostname | pippin.serverhome.home |  |
| OS Version | [raspios_lite_arm64-2021-05-28](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2021-05-28/2021-05-07-raspios-buster-arm64-lite.zip) |  |
| CPU | Broadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @ 1.5GHz | 1 |
| Memory | 4GB LPDDR4-3200 SDRAM | 1 |
| Сеть | Gigabit LAN ports - RG-45 | 1 |
| Слоты системы хранения | - |  |
| Система хранения | SSD Samsung 850 EVO MZ-M5E120 - 120 GB (USB) | 1 |
| Блок питания | ONEPLUS 6T, 5 В/4A | 1 |
| IPMI | - |  |
| BIOS version | c305221a6d7e532693cc7ff57fddfc8649def167 |  |
| IPMI version | - |  |

## Установка OS

1. Скачать актуальную версию дистрибутива raspios https://downloads.raspberrypi.org/raspios_lite_arm64/images/
2. Скачать утилиту для записи образа https://sourceforge.net/projects/win32diskimager/
3. Записать через утилиту образ дистрибутива raspios на устройство, которое будет использоваться как системный диск (micro-sd карта, ssd usb диск и т.д)
4. После записи, в корне раздела boot создать пустой файл с именем `ssh`
5. Подключить системный диск к raspberry pi, подать питание

## Настройка OS

1. Заходим по ssh на сервер
2. Делаем:

       sudo apt update
       sudo apt upgrade
       sudo reboot
       sudo rpi-update
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
       git clone https://github.com/alexanderfefelov/scripts
       git clone git@github.com:chatlamin/serverhome.git
       git clone git@github.com:chatlamin/pippin.system.git

8. Подготавливаем профиль и OS для работы

        cd $HOME/github/scripts/install/ && ./RUN-ME-FIRST.sh
        cd $HOME/github/scripts/install/ && ./install-useful-tools.sh

   <details>
   <summary>на 24.07.2021</summary>
   Эти пакеты не устанавливаются. Удалить из скрипта установки:

   E: Unable to locate package bat

   E: Unable to locate package petname

   E: Unable to locate package clickhouse-client

   E: Package 'mongodb-clients' has no installation candidate

   E: Package 'mysql-client' has no installation candidate

   При установке smb выбрать no

   </details>

9. Установка docker

       apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
       curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
       echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       apt-get update
       apt-get install docker-ce docker-ce-cli containerd.io

10. Синхронизируем каталог /etc с репозиторием

        sudo cp -r /etc $HOME/github/pippin.system
        cd $HOME/github/pippin.system
        sudo chown -R ВАШ_ЛОГИН:ВАШ_ЛОГИН etc/
        git add --all .
        git commit -m "start"
        git push

11. Меняем hostname

    Редактируем файл hostname

        sudo mcedit /etc/hostname
    Меняем текущий hostname на pippin.serverhome.home
    <details>
    <summary>Полный конфиг</summary>

        pippin.serverhome.home
    </details>

    Редактируем файл hosts

        sudo mcedit /etc/hosts
    Меняем текущий hostname на pippin.serverhome.home
    <details>
    <summary>Полный конфиг</summary>

        127.0.0.1<----->localhost
        ::1<---><------>localhost ip6-localhost ip6-loopback
        ff02::1><------>ip6-allnodes
        ff02::2><------>ip6-allrouters

        127.0.1.1<-----><------>pippin.serverhome.home

    </details>

12. Фиксируем изменения hostname и hosts

        sudo cp -r /etc $HOME/github/pippin.system
        cd $HOME/github/pippin.system
        sudo chown -R ВАШ_ЛОГИН:ВАШ_ЛОГИН etc/
        git add --all .
        git commit -m "Настройка hostname"
        git push

13. Устанавливаем правильную timezone

        sudo timedatectl set-timezone Europe/Moscow

14. Фиксируем изменения timezone

        sudo cp -r /etc $HOME/github/pippin.system
        cd $HOME/github/pippin.system
        sudo chown -R ВАШ_ЛОГИН:ВАШ_ЛОГИН etc/
        git add --all .
        git commit -m "Настройка timezone"
        git push

15. Отключаем Avahi-daemon https://www.spaetzle.info/raspberry-server/#Stop_the_avahi_service

        sudo systemctl stop avahi-daemon.service
        sudo systemctl stop avahi-daemon.socket
        sudo systemctl disable avahi-daemon.service
        sudo systemctl disable avahi-daemon.socket

16. Настройка статического ip https://raspberrypi.stackexchange.com/a/106914

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
        dns-nameservers 172.17.0.1 8.8.8.8

17. Отключаем кэширующий dns systemd-resolved

        sudo systemctl disable systemd-resolved.service
        sudo systemctl stop systemd-resolved
        sudo rm /etc/resolv.conf

18. Перезагрузка

        sudo reboot

19. Перенастраиваем swap

        swapon --show
        swapoff /var/swap
        rm -f /var/swap
        fallocate -l 2G /swapfile
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
20. Фиксируем изменения swap

        sudo cp -r /etc $HOME/github/pippin.system
        cd $HOME/github/pippin.system
        sudo chown -R ВАШ_ЛОГИН:ВАШ_ЛОГИН etc/
        git add --all .
        git commit -m "Настройка swap"
        git push

___

Тест скорости:


SSD Samsung 850 EVO MZ-M5E120 - 120 GB (USB)
```
time sh -c "dd if=/dev/zero of=/data1/ddfile.tmp bs=1M count=10000"
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB, 9.8 GiB) copied, 55.6507 s, 188 MB/s

real    0m55.663s
user    0m0.090s
sys     0m40.042s
```