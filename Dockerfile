FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD import_sql.sh /import_sql.sh
ADD create_db.sh /create_db.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite


EXPOSE 80 3306
CMD ["/run.sh"]
