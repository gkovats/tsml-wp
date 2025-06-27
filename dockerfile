FROM wordpress:6.7.2-php8.4-apache

# Install packages under Debian
RUN apt-get update && \
    apt-get -y install git

# Install XDebug from source as described here:
# https://xdebug.org/docs/install
# Available branches of XDebug could be seen here:
# https://github.com/xdebug/xdebug/branches
RUN cd /tmp && \
    git clone https://github.com/xdebug/xdebug.git && \
    cd xdebug && \
    git checkout xdebug_3_4 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    make install && \
    rm -rf /tmp/xdebug

# Copy xdebug.ini to /usr/local/etc/php/conf.d/
COPY scripts/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN docker-php-ext-enable xdebug
