# testlink.docker

Docker Hub Repository: https://hub.docker.com/r/suzukishunsuke/testlink/

* Debian 8.6
* testlink 1.9.15
* apache
* dumb-init 1.2.0
* EXPOSE 80
* ENTRYPOINT: /usr/bin/dumb-init
* ENV
  * ENV APACHE_RUN_USER=www-data
  * APACHE_RUN_GROUP=www-data
  * APACHE_LOG_DIR=/var/log/apache2
  * APACHE_PID_FILE=/var/run/apache2.pid
  * APACHE_RUN_DIR=/var/run/apache2
  * APACHE_LOCK_DIR=/var/lock/apache2
  * TERM=xterm
  * TESTLINK_VERSION=1.9.15
  * DUMB_INIT_VERSION=1.2.0


## Run

You have to the external database server.

Run the docker container and access to /testlink with the web browser.
Testlink has the web based installer.

### Use mysql container

```
$ docker run -d -p 80:80 --name testlink --hostname testlink --link mysql:mysql suzukishunsuke/testlink
```

```yaml
# docker-compose.yml
testlink:
  image: suzukishunsuke/testlink
  hostname: testlink
  ports:
  - "80:80"
  links:
  - mysql
mysql:
  image: mysql:5.6.29
  hostname: mysql
  environment:
    MYSQL_ROOT_PASSWORD: password
```

### Use mysql server

```
$ docker run -d -p 80:80 --name testlink --hostname testlink suzukishunsuke/testlink
```

```yaml
# docker-compose.yml
testlink:
  image: suzukishunsuke/testlink
  hostname: testlink
  ports:
  - "80:80"
```
