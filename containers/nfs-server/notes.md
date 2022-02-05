# notes


https://blog.ruanbekker.com/blog/2020/09/20/setup-a-nfs-server-with-docker/

Для проверки установите на другой машине nfs-client

    sudo apt-get install nfs-client

И выполните:

    mount -v -o vers=4,loud 192.168.88.4:/ /mnt/nfs-server/