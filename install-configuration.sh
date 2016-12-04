#!/bin/bash

set -e

export OSIAM_HOME=/var/lib/osiam
mkdir ${OSIAM_HOME}
java -jar osiam/build/libs/osiam.war initHome
mv osiam.yaml ${OSIAM_HOME}/config/osiam.yaml
chown -R tomcat8:tomcat8 ${OSIAM_HOME}

mkdir /etc/osiam

mv addon-self-administration/src/main/deploy/* /etc/osiam
cat addon-self-administration.properties >> /etc/osiam/addon-self-administration.properties

mv addon-administration/src/main/deploy/* /etc/osiam
sed -i 's/org.osiam.mail.server.smtp.port=25/org.osiam.mail.server.smtp.port=10025/g' /etc/osiam/addon-administration.properties
sed -i 's/your.smtp.server.com/localhost/g' /etc/osiam/addon-administration.properties
sed -i 's/org.osiam.mail.server.username=username/org.osiam.mail.server.username=user1/g' /etc/osiam/addon-administration.properties

mv supervisord.conf /etc/supervisor/conf.d/osiam.conf
