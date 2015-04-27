#!/bin/bash

INSTALLER_DIR=/install

. $INSTALLER_DIR/build.conf

OSIAM_DIST_DIR="$INSTALLER_DIR/osiam-distribution-$OSIAM_VERSION"

# download osiam and prepare for installation
# mvn initialize
curl -o $INSTALLER_DIR/osiam-dist.tgz \
    https://maven-repo.evolvis.org/releases/org/osiam/osiam-distribution/$OSIAM_VERSION/osiam-distribution-$OSIAM_VERSION.tar.gz
tar -C $INSTALLER_DIR/ -xzf $INSTALLER_DIR/osiam-dist.tgz

# add configs
mkdir /etc/osiam
mv $OSIAM_DIST_DIR/osiam-server/osiam-resource-server/configuration/* /etc/osiam
mv $OSIAM_DIST_DIR/osiam-server/osiam-auth-server/configuration/* /etc/osiam
mv $OSIAM_DIST_DIR/addon-self-administration/configuration/* /etc/osiam
mv $OSIAM_DIST_DIR/addon-administration/configuration/* /etc/osiam
mv $INSTALLER_DIR/supervisord.conf /etc/supervisor/conf.d/osiam.conf

# setup database
useradd -M -s /bin/false -U ong
echo "local all all           md5" >> /etc/postgresql/9.1/main/pg_hba.conf
echo "host  all all 0.0.0.0/0 md5" >> /etc/postgresql/9.1/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/9.1/main/postgresql.conf
/etc/init.d/postgresql start
echo "CREATE USER ong WITH PASSWORD 'b4s3dg0d';" | sudo -u postgres psql
echo "CREATE DATABASE ong;" | sudo -u postgres psql
echo "GRANT ALL PRIVILEGES ON DATABASE ong TO ong;" | sudo -u postgres psql
sudo -u ong psql -f $OSIAM_DIST_DIR/addon-self-administration/sql/init_data.sql -U ong
# import setup data
sudo -u ong psql -f $INSTALLER_DIR/setup_data.sql -U ong

# setup tomcat
find $OSIAM_DIST_DIR -name '*.war' -exec mv {} /var/lib/tomcat7/webapps/ \;
sudo -u tomcat7 -g tomcat7 mkdir /tmp/tomcat7-tomcat7-tmp
sed -i "/^shared\.loader=/c\shared.loader=/var/lib/tomcat7/shared/classes,/var/lib/tomcat7/shared/*.jar,/etc/osiam" /etc/tomcat7/catalina.properties
sed -i "/^JAVA_OPTS=/c\JAVA_OPTS=\"-Djava.awt.headless=true -Xms512m -Xmx1024m -XX:+UseConcMarkSweepGC\"" /etc/default/tomcat7

# cleanup
rm -rf $INSTALLER_DIR
