#!/bin/bash

set -e

mkdir /var/lib/osiam
chown tomcat8:tomcat8 /var/lib/osiam

mkdir /etc/osiam

mv addon-self-administration/src/main/deploy/* /etc/osiam
cat addon-self-administration.properties >> /etc/osiam/addon-self-administration.properties

mv addon-administration/src/main/deploy/* /etc/osiam
sed -i 's/org.osiam.mail.server.smtp.port=25/org.osiam.mail.server.smtp.port=10025/g' /etc/osiam/addon-administration.properties
sed -i 's/your.smtp.server.com/localhost/g' /etc/osiam/addon-administration.properties
sed -i 's/org.osiam.mail.server.username=username/org.osiam.mail.server.username=user1/g' /etc/osiam/addon-administration.properties

mv supervisord.conf /etc/supervisor/conf.d/osiam.conf
