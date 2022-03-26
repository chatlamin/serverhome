# Подготовка сервера под ключ

## Исходные данные

OS Version [ubuntu-20.04.2-live-server-amd64](https://releases.ubuntu.com/20.04/ubuntu-20.04.2-live-server-amd64.iso)

## Установка OS

1. Скачать актуальную версию дистрибутива ubuntu-server https://releases.ubuntu.com/
2. Скачать утилиту для записи образа https://rufus.ie/ru/
3. Записать через утилиту установочный образ дистрибутива ubuntu-server на устройство, которое будет использоваться как загрузочный диск (usb-флешка)
4. Подключить загрузочный диск к серверу, подать питание
5. Выбираем язык установки Русский
6. Выбираем раскладку Layout: Английская (американская), Variant: Английская (американская) - по умолчанию, жмем Готово
7. Сетевые соединения жмем Готово (оставляем dhcp)
8. Настройка прокси-сервер: не указываем - по умолчанию, жмем Готово
9. Настройка зеркала репозиториев: http://archive.ubuntu.com/ubuntu - по умолчанию, жмем Готово
10. Конфигурация хранилища: Снять крестик с Set up this disk as an LVM group, жмем Готово -> Готово -> Продолжить
11. Установки профиля

- Ваше имя: username
- Your servers name: server1
- Введите имя пользователя: username
- Задайте пароль: ***
- Подтвердите пароль: ***
- Готово

12. Установка SSH: выбрать Install OpenSSH server.
13. Featured Server Snapc: ничего не выбирать, по умолчанию - Готово.

## Настройка OS

1. Заходим по ssh на сервер
2. Делаем:

       sudo apt update
       sudo apt upgrade
       sudo apt install mc

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

       cd $HOME/github/serverhome/scripts/install/amd64/ubuntu/ && ./install-tools.sh
       cd $HOME/github/serverhome/scripts/install/amd64/ubuntu/ && ./install-docker.sh
       cd $HOME/github/serverhome/scripts/install/amd64/ubuntu/ && ./install-docker-compose.sh

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

       127.0.0.1 localhost
       127.0.1.1 server1.serverhome.home
        
       # The following lines are desirable for IPv6 capable hosts
       ::1     ip6-localhost ip6-loopback
       fe00::0 ip6-localnet
       ff00::0 ip6-mcastprefix
       ff02::1 ip6-allnodes
       ff02::2 ip6-allrouters

    </details>

10. Устанавливаем правильную timezone

        sudo timedatectl set-timezone Europe/Moscow

11. Настройка статического ip https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-20-04/

        sudo mcedit /etc/netplan/00-installer-config.yaml


    <details>
    <summary>Полный конфиг</summary>

        # This is the network config written by 'subiquity'
        network:
          ethernets:
            eth0:
              dhcp4: no
              optional: true
              addresses:
              - 192.168.88.4/24
              gateway4: 192.168.88.1
          version: 2

    </details>

        sudo netplan generate
        sudo netplan apply

12. Отключаем на хосте кэширующий dns systemd-resolved для работы dns сервера в докер-контейнере

        sudo systemctl disable systemd-resolved.service
        sudo systemctl stop systemd-resolved
        sudo rm /etc/resolv.conf
        sudo bash -c 'echo nameserver 172.17.0.1 > /etc/resolv.conf'
        sudo bash -c 'echo nameserver 8.8.8.8 >> /etc/resolv.conf'

    <details>
    <summary>Возможные проблемы</summary>
    Докер сеть bridge может быть 172.18.0.0/16. Проверяем так:

        sudo docker network inspect bridge
    </details>

13. Перезагрузка

        sudo reboot

14. Перенастраиваем swap

        swapon --show
        swapoff /swap.img
        rm -f /swap.img
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

15. Создать служебного пользователя для резервного копирования

        sudo adduser backuper
        sudo usermod -aG sudo backuper

16. Настроить команды, которые пользователь backuper может делать без ввода пароля

        sudo pkexec visudo

        # Вписать в конец:
        backuper ALL = NOPASSWD: /bin/mkdir, /bin/tar, /bin/gzip, /usr/bin/find, /bin/mv, /usr/bin/zip, /bin/rm, /usr/bin/mysqldump, /usr/bin/cp
