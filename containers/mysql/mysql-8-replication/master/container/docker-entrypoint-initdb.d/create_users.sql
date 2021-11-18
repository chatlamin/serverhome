CREATE USER 'root'@'%' IDENTIFIED BY 'Dae2fiiChohng0';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE USER 'replication_user'@'%' IDENTIFIED WITH mysql_native_password BY 'eiCheizaew3eek';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replication_user'@'%';