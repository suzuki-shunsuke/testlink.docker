FROM debian:8.6
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid \
    APACHE_RUN_DIR=/var/run/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    TERM=xterm \
    TESTLINK_VERSION=1.9.15 \
    DUMB_INIT_VERSION=1.2.0
RUN apt-get update && \
    apt-get install -y apache2 php5 wget php5-mysql && \
    wget -q http://downloads.sourceforge.net/project/testlink/TestLink%201.9/TestLink%20${TESTLINK_VERSION}/testlink-${TESTLINK_VERSION}.tar.gz && \
    tar zxvf testlink-${TESTLINK_VERSION}.tar.gz && \
    mv testlink-${TESTLINK_VERSION} /var/www/html/testlink && \
    rm testlink-${TESTLINK_VERSION}.tar.gz && \
    echo "max_execution_time=3000" >> /etc/php5/apache2/php.ini && \
    echo "session.gc_maxlifetime=60000" >> /etc/php5/apache2/php.ini && \
    mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR /var/testlink/logs /var/testlink/upload_area && \
    chmod 777 -R /var/www/html/testlink /var/testlink/logs /var/testlink/upload_area && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64.deb && \
    dpkg -i dumb-init_${DUMB_INIT_VERSION}_amd64.deb && \
    rm dumb-init_${DUMB_INIT_VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*
EXPOSE 80/tcp
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
