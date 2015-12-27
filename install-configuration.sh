#!/bin/bash

set -e

mkdir /etc/osiam
mv auth-server/src/main/deploy/* /etc/osiam
mv resource-server/src/main/deploy/* /etc/osiam
mv addon-self-administration/src/main/deploy/* /etc/osiam
mv addon-administration/src/main/deploy/* /etc/osiam

cat addon-self-administration.properties >> /etc/osiam/addon-self-administration.properties

sed -i 's/\(org\.osiam\.endpoint=.*\)/#\1/g' /etc/osiam/addon-administration.properties
sed -i 's/org.osiam.mail.server.smtp.port=25/org.osiam.mail.server.smtp.port=10025/g' /etc/osiam/addon-administration.properties
sed -i 's/your.smtp.server.com/localhost/g' /etc/osiam/addon-administration.properties
sed -i 's/org.osiam.mail.server.username=username/org.osiam.mail.server.username=user1/g' /etc/osiam/addon-administration.properties

mv supervisord.conf /etc/supervisor/conf.d/osiam.conf
