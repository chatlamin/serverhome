# notes

https://blog.ruanbekker.com/blog/2020/09/20/setup-a-nfs-server-with-docker/

Для проверки установите на другой машине nfs-client

    sudo apt-get install nfs-client

И выполните:

    mount -v -o vers=4,loud 192.168.88.4:/ /mnt/nfs-server/


https://docs.docker.com/storage/volumes/#create-a-service-which-creates-an-nfs-volume

https://blogs.oracle.com/cloud-infrastructure/post/mounting-oci-file-storage-and-other-nfs-shares-on-docker-containers

Для монтирования в любой другой контейнер, на любой другой машине, как клиент, добавьте к команде `docker run`:

    --mount 'type=volume,source=homer-point,target=/mnt-point,volume-driver=local,volume-opt=type=nfs,volume-opt=device=:/,"volume-opt=o=addr=192.168.88.4,rw,nfsvers=4,async"' \

где:

- type=volume - тип (том)
- source=homer-point - как том будет называться на хосте, в каталоге /var/lib/docker/volumes
- target=/mnt-point - путь тома внутри контейнера
- volume-driver=local - драйвер тома
- volume-opt=type=nfs - тип драйвера
- volume-opt=device=:/ - каталог на nfs-server
- volume-opt=o=addr=192.168.88.4 - ip адрес nfs-server
- rw,nfsvers=4,async - доп опции (аналогично команде mount -o)