# notes

Ошибка:
[1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

Решение:
В /etc/sysctl.conf добавить

```
# https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
vm.max_map_count=262144
```
перезагрузить систему