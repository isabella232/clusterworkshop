FROM centos:7
RUN yum -y install wget epel-release nano sudo curl which git
RUN yum -y update

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
RUN yum -y install MariaDB-server maxscale
COPY scripts/server.cnf /etc/my.cnf.d/server.cnf
COPY scripts/maxscale.cnf /etc/maxscale.cnf

RUN mkdir -p /mariadb/{1,2,3}/data
RUN mkdir -p /mariadb/{1,2,3}/log
RUN mysql_install_db --datadir=/mariadb/1/data/
RUN chown -R mysql:mysql /mariadb
RUN mkdir -p /root/scripts/

COPY scripts/bootstrap.sh /root/scripts/bootstrap.sh
COPY scripts/mariadb_sig.txt /root/scripts/mariadb_sig.txt
COPY scripts/*.sql /root/scripts/
COPY scripts/.my.cnf /root/.my.cnf

RUN chmod +x /root/scripts/bootstrap.sh

RUN cat /root/scripts/mariadb_sig.txt >> /etc/MOTD
RUN echo "clear;cat /etc/MOTD" >> ~/.bashrc

ENTRYPOINT ["/root/scripts/bootstrap.sh"]
