#!/bin/sh


if [ ! -z ${ICINGA2_IDO_PGSQL_PASSWD} ];
then
    sed -i "s/_DBC_TYPE_/pgsql/" /etc/icingaweb2/resources.ini
    sed -i "s/_DBC_HOST_/${ICINGA2_IDO_PGSQL_HOST:-172.17.0.1}/" /etc/icingaweb2/resources.ini
    sed -i "s/_DBC_PORT_/${ICINGA2_IDO_PGSQL_PORT:-5432}/" /etc/icingaweb2/resources.ini
    sed -i "s/_DBC_DBNAME_/${ICINGA2_IDO_PGSQL_NAME:-icinga2-ido}/" /etc/icingaweb2/resources.ini
    sed -i "s/_DBC_DBUSER_/${ICINGA2_IDO_PGSQL_USER:-icinga2-ido}/" /etc/icingaweb2/resources.ini
    sed -i "s/_DBC_DBPASS_/${ICINGA2_IDO_PGSQL_PASSWD}/" /etc/icingaweb2/resources.ini
fi

echo "Starting Apache"
rm -f /usr/local/apache2/logs/httpd.pid

. /etc/apache2/envvars

exec /usr/sbin/apache2 -DFOREGROUND
