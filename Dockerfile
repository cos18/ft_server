FROM	debian:buster
RUN		apt-get update
RUN		apt-get upgrade -y
RUN		apt-get install -y nginx
RUN		apt-get install -y php php-fpm php-mysql
RUN		apt-get install -y wget
RUN		apt-get install -y libnss3-tools
RUN		apt-get install -y mariadb-server

COPY	src/init.sh ./root/
COPY	src/wp.tar.gz ./root/
COPY	src/localhost.conf ./root/
COPY 	src/init.sql ./root/
COPY	src/phpMyAdmin.tar.gz ./root/
COPY	src/wordpress.sql ./root/
CMD		bash ./root/init.sh && /bin/bash