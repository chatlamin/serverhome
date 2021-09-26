# notes
Если инсталяция подключается к существующей базе, выполните:
1. `sudo docker exec -it bookstack php /var/www/html/artisan bookstack:update-url https://example.com http://bookstack.serverhome.home:65001`
2. `sudo docker exec -it bookstack php /var/www/html/artisan cache:clear`