FROM ubuntu:quantal
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen

# Add image configuration and scripts
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/start-apache2.sh /start-apache2.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/start-mysqld.sh /start-mysqld.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/run.sh /run.sh
RUN chmod 755 /*.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/my.cnf /etc/mysql/conf.d/my.cnf
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Add MySQL utils
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/import_sql.sh /import_sql.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-lamp/master/create_db.sh /create_db.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /app && rm -fr /var/www && ln -s /app /var/www

EXPOSE 80 3306
CMD ["/run.sh"]
