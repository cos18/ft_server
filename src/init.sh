mkdir -p /var/www/root
cp /root/localhost.conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

mkdir ~/mkcert
cd ~/mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64
mv mkcert-v1.4.1-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install
./mkcert localhost

service mysql start
mysql -uroot < /root/init.sql

mv /root/wp.tar.gz /var/www/root
cd /var/www/root
tar -xvzf wp.tar.gz
rm -rf wp.tar.gz

mkdir phpmyadmin
cd phpmyadmin
mv /root/phpMyAdmin.tar.gz ./
tar -xvzf phpMyAdmin.tar.gz
rm -rf phpMyAdmin.tar.gz

mysql wordpress -uroot < /root/wordpress.sql

chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
service mysql restart
service php7.3-fpm start
service nginx restart