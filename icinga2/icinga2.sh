#!/bin/sh

if [ ! -z ${ICINGA2_IDO_PGSQL_PASSWD} ];
then
    /usr/sbin/icinga2 feature enable ido-pgsql
    cp /usr/share/icinga2/tmpl/ido-pgsql.conf-sample /etc/icinga2/features-available/ido-pgsql.conf.tmp
    sed -i "s/_DBC_DBUSER_/${ICINGA2_IDO_PGSQL_USER:-icinga2-ido}/" /etc/icinga2/features-available/ido-pgsql.conf.tmp
    sed -i "s/_DBC_DBPASS_/${ICINGA2_IDO_PGSQL_PASSWD}/" /etc/icinga2/features-available/ido-pgsql.conf.tmp
    sed -i "s/_DBC_DBSERVER_/${ICINGA2_IDO_PGSQL_HOST:-localhost}/" /etc/icinga2/features-available/ido-pgsql.conf.tmp
    sed -i "s/_DBC_DBNAME_/${ICINGA2_IDO_PGSQL_DBNAME:-icinga2-ido}/" /etc/icinga2/features-available/ido-pgsql.conf.tmp
    mv /etc/icinga2/features-available/ido-pgsql.conf.tmp /etc/icinga2/features-available/ido-pgsql.conf
fi
echo "Starting Icinga2 Daemon"
exec /usr/sbin/icinga2 daemon -e /var/log/icinga2/icinga2.err
