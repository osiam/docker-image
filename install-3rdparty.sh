#!/bin/bash

set -e

# install greenmail webapp to provide simple smtp service for the self-administration and administration
curl -o greenmail.war http://central.maven.org/maven2/com/icegreen/greenmail-webapp/1.4.1/greenmail-webapp-1.4.1.war
unzip greenmail.war -d /var/lib/tomcat8/webapps/greenmail
sed -i 's/127.0.0.1/0.0.0.0/g' /var/lib/tomcat8/webapps/greenmail/WEB-INF/web.xml

# install maven
MAVEN_VERSION=3.3.9
curl -o apache-maven.tgz ftp://ftp.fu-berlin.de/unix/www/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
tar -xzf apache-maven.tgz
mv apache-maven-${MAVEN_VERSION} /opt/apache-maven
ln -s /opt/apache-maven/bin/mvn /usr/local/bin/mvn
