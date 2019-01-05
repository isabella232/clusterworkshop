#!/bin/bash
echo 'Please standby while a new Galera cluster is bootstrapped and sample data is loaded ...'

mysqld_multi start 1 --wsrep-new-cluster

until [[ $(mysql -P 3307 -u root --password="" -sN -e "SELECT VARIABLE_VALUE FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME = 'WSREP_LOCAL_STATE'" 2> /dev/null) = 4 ]]; do
	sleep 5
done

mysql -h 127.0.0.1 -P 3307 -u root --password="" < /root/scripts/mariadb.sql

mysqld_multi start 2

until [[ $(mysql -P 3308 -sN -e "SELECT VARIABLE_VALUE FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME = 'WSREP_LOCAL_STATE'" 2> /dev/null) = 4 ]]; do
	sleep 5
done

mysqld_multi start 3

until [[ $(mysql -P 3309 -sN -e "SELECT VARIABLE_VALUE FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME = 'WSREP_LOCAL_STATE'" 2> /dev/null) = 4 ]]; do
	sleep 5
done

mysql -h 127.0.0.1 -P 3308 -u dba --password="demo_password" < /root/scripts/sakila-schema.sql

mysql -h 127.0.0.1 -P 3308 -u dba --password="demo_password" < /root/scripts/sakila-data.sql

sudo -u maxscale /usr/bin/maxscale &

exec "$@"

bash
