ошибка ERROR 2061 (HY000): RSA Encryption not supported - caching_sha2_password plugin was built with GnuTLS support

https://stackoverflow.com/a/49935803

фиксим:

    docker exec -i mysql /usr/bin/mysql -u root --password=Dae2fiiChohng0 <<< "ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'Dae2fiiChohng0';"