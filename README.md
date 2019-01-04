# MariaDB Galera Cluster Workshop

# Summary #
This image can be used for testing, labs, demos, etc.

# Environment #
This docker image has 1 MaxScale instance and 3 MariaDB Galera instances installed. All listening on different ports:

* Maxscale - 3306
* Node1 - 3307
* Node2 - 3308
* Node3 - 3309

# Prerequisites #

* [Docker](https://www.docker.com/products/docker-desktop)
* [git](https://git-scm.com/downloads)

# Getting Started #
```
1. $ git clone https://github.com/mariadb-corporation/clusterworkshop.git
2. $ cd clusterworkshop
3. $ docker build . -t clusterworkshop
4. $ docker run -it clusterworkshop
```
To connect to the Galera cluster through MaxScale:

```
$ mysql
```
To view cluster information through Maxscale:

```
$ maxctrl list servers
```

To start (or stop) an individual Galera node:
```
$ mysqld_multi start 1 ### Starts node 1
$ mysqld_multi stop  1 ### Stops node 1
```
