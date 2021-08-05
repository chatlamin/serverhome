# Ссылки на проект
https://www.mongodb.com/

https://github.com/mongodb/mongo

https://github.com/docker-library/mongo

https://hub.docker.com/_/mongo

Логин root пароль wah7nie6naZ0ka

В помощь https://gist.github.com/oleurud/d9629ef197d8dab682f9035f4bb29065

Запуск кластера:
1. Выполнить ./build.sh
2. Выполнить ./run-1.sh
3. Выполнить ./run-2.sh
4. Выполнить ./run-3.sh
5. Выполнить `sudo docker exec -it mongodb-1 mongo`
6. Выполнить `db = (new Mongo('localhost:27017')).getDB('test')`
7. Выполнить `config={"_id":"rs01","members":[{"_id":0,"host":"mongodb-1.serverhome.home:27017"},{"_id":1,"host":"mongodb-2.serverhome.home:27018"},{"_id":2,"host":"mongodb-3.serverhome.home:27019"}]}`
8. Выполнить `rs.initiate(config)` . Ожидаемый вывод `{ "ok" : 1 }` - значит все хорошо.
9. Выполнить `exit`

Создать пользователя:
1. Выполнить `sudo docker exec -it mongodb-1 mongo`
2. Выполнить `use admin`
3. Выполнить `db.createUser( { user: "root", pwd: "wah7nie6naZ0ka", roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ] } )`
4. Выполнить `exit`

Проверить подключение можно с помощью GUI утилиты под Windows https://www.mongodb.com/try/download/compass (прямая ссылка на скачивание https://downloads.mongodb.com/compass/mongodb-compass-1.28.1-win32-x64.zip)

После установки утилиты вы можете создать новый коннект для администрирования кластера с адресом: mongodb://root:wah7nie6naZ0ka@IP-ADDRESS-ВАШЕГО-СЕРВЕРА:27017/