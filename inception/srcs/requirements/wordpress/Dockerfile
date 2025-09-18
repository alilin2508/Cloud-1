FROM alpine:3.18

RUN apk update && apk upgrade
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.16/community" >> /etc/apk/repositories
RUN apk add php8 \
	php8-fpm \
	php8-mysqli \
	php8-phar \
	php8-mbstring \
	mysql-client \
	wget

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp && wp cli update
WORKDIR /var/www/html
RUN wget https://wordpress.org/wordpress-6.4.2.tar.gz && \
    tar -xzvf wordpress-6.4.2.tar.gz && \
	rm -rf wordpress-6.4.2.tar.gz

COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY ./tools/entrypoint.sh /entrypoint/
RUN chmod +x /entrypoint/entrypoint.sh

ENTRYPOINT ["/entrypoint/entrypoint.sh"]
