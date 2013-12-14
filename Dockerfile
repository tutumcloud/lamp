FROM ubuntu:quantal
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update && apt-get -y upgrade && ! DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql

# Add image configuration and scripts
ADD ./start-apache2.sh /start-apache2.sh
ADD ./start-mysqld.sh /start-mysqld.sh
ADD ./run.sh /run.sh
ADD ./my.cnf /etc/mysql/conf.d/my.cnf
ADD ./supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD ./supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Add MySQL utils
ADD ./set_mysql_root_pw.sh /set_mysql_root_pw.sh
ADD ./import_sql.sh /import_sql.sh
ADD ./create_db.sh /create_db.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /app && rm -fr /var/www && ln -s /app /var/www

EXPOSE 80
CMD ["/run.sh"]
