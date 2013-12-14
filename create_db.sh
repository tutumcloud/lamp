#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "Usage: $0 <db_name>"
	exit 1
fi

echo "=> Starting MySQL Server"
/usr/bin/mysqld_safe > /dev/null 2>&1 &
echo "   Started with PID $!"

echo "=> Creating database"
RET=1
while [[ RET -ne 0 ]]; do
	sleep 5
	mysql -uroot -e "CREATE DATABASE $1"
	RET=$?
done

echo "=> Stopping MySQL Server"
mysqladmin -uroot shutdown

echo "=> Done!"
