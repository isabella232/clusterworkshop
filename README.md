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

* [docker](https://www.docker.com/products/docker-desktop)
* [git](https://git-scm.com/downloads)

# Getting Started #
```
$ git clone https://github.com/mariadb-corporation/clusterworkshop.git
$ cd clusterworkshop
$ docker build . -t clusterworkshop
$ docker run -it clusterworkshop
```

To view cluster information through Maxscale:

```
$ maxctrl list servers
```

To connect to the Galera cluster through MaxScale:

```
$ mysql
```

To connect to an individual Galera node directly:

```
$ mysql -P 3307  ### Node1
$ mysql -P 3308  ### Node2
$ mysql -P 3309  ### Node3
```

To start (or stop) an individual Galera node:
```
$ mysqld_multi start 1 ### Start Node1
$ mysqld_multi stop  1 ### Stop Node1
```
