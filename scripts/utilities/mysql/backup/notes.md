# notes
https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded

ошибка mysqldump: Got error: 1045: "Plugin caching_sha2_password could not be loaded: /usr/lib/aarch64-linux-gnu/mariadb19/plugin/caching_sha2_password.so: cannot open shared object file: No such file or directory" when trying to connect

фиксим

    docker exec -i mysql /usr/bin/mysql -u root --password=Dae2fiiChohng0 <<< "ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'Dae2fiiChohng0';"