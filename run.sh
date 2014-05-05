#!/bin/bash
if [ "$ENABLE_HTACCESS"x = 'Truex' ]; then
	/enable_htaccess.sh
fi

if [ ! -f /.mysql_admin_created ]; then
	/create_mysql_admin_user.sh
fi

exec supervisord -n
