#!/bin/bash


if [ ! -z ${ICINGAWEB2_ADMIN_PASSWD} ] && [ ! -z ${ICINGAWEB2_ADMIN_USER} ];
then
HASHEDPASS=`openssl passwd -1 ${ICINGAWEB2_ADMIN_PASSWD}`
psql --username ${POSTGRES_USER} --dbname ${POSTGRES_DB} <<-EOSQL
INSERT INTO icingaweb_user (name, active, password_hash) VALUES ('${ICINGAWEB2_ADMIN_USER}', 1, '${HASHEDPASS}');
EOSQL
echo
fi
