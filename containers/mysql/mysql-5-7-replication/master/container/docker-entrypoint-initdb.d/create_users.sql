CREATE USER 'replication_user'@'%' IDENTIFIED WITH mysql_native_password BY 'WeiGhaif9ail6d';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replication_user'@'%';