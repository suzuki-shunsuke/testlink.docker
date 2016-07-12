FROM debian:8.5
RUN apt-get update && \
    apt-get install -y apache2 php5 wget php5-mysql && \
    wget -q http://sourceforge.net/projects/testlink/files/TestLink%201.9/TestLink%201.9.14/testlink-1.9.14.tar.gz/download -O testlink-1.9.14.tar.gz && \
    tar zxvf testlink-1.9.14.tar.gz && \
    mv testlink-1.9.14 /var/www/html/testlink && \
    rm testlink-1.9.14.tar.gz && \
    echo "max_execution_time=3000" >> /etc/php5/apache2/php.ini && \
    echo "session.gc_maxlifetime=60000" >> /etc/php5/apache2/php.ini && \
    mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR /var/testlink/logs /var/testlink/upload_area && \
    chmod 777 -R /var/www/html/testlink /var/testlink/logs /var/testlink/upload_area && \
    wget https://github.com/Yelp/dumb-init/releases/download/v1.1.1/dumb-init_1.1.1_amd64.deb && \
    dpkg -i dumb-init_1.1.1_amd64.deb && \
    rm dumb-init_1.1.1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*
ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 APACHE_PID_FILE=/var/run/apache2.pid APACHE_RUN_DIR=/var/run/apache2 APACHE_LOCK_DIR=/var/lock/apache2 TERM=xterm
EXPOSE 80/tcp
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
