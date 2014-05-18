#!/bin/bash

if [ ! -f /.mysql_admin_created ]; then
	chown mysql:mysql -R /var/lib/mysql
        mysql_install_db
	/create_mysql_admin_user.sh
fi

exec supervisord -n
