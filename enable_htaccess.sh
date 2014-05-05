#!/bin/bash
set -e
echo "Enabling .htaccess"
cp apache_default /etc/apache2/sites-available/default
a2enmod rewrite
echo ".htaccess Enabled"
