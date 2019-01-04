#!/bin/bash
echo 'Please standby while a new Galera cluster is bootstrapped and sample data is loaded ...'
mysqld_multi start 1 --wsrep-new-cluster
sleep 15
mysql -h 127.0.0.1 -P 3307 -u root --password="" < /root/scripts/mariadb.sql
mysqld_multi start 2
sleep 15
mysqld_multi start 3
sleep 15
mysql -h 127.0.0.1 -P 3308 -u dba --password="demo_password" < /root/scripts/sakila-schema.sql
mysql -h 127.0.0.1 -P 3308 -u dba --password="demo_password" < /root/scripts/sakila-data.sql
sudo -u maxscale /usr/bin/maxscale &
exec "$@"
bash
