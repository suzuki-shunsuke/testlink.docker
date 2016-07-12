# testlink.docker

Docker Hub Repository: https://hub.docker.com/r/suzukishunsuke/testlink/

* Debian 8.5
* testlink 1.9.14
* apache
* dumb-init 1.1.1
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

```
$ docker run -d -p 80:80 --name testlink --link mysql:mysql suzukishunsuke/testlink
```
