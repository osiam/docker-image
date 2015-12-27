# OSIAM Docker Image

This project builds a docker image with OSIAM installed and configured ready to 
use for development purposes. **WARNING:** This image is for development purposes 
only! Do not even think about using it in a production-like environment!

## Installation details

* includes resource-server, auth-server, addon-self-administration,
  addon-administration
* full postgres database already installed
* default sample data included
* running greenmail fake mail server to provide fully functional addons
* a few dev tools are included for convenience: maven, flyway, git, less, vim,
  openjdk7-jdk, curl, unzip

## Use the image

Run with:

    $ docker run -i -t -p 8080:8080 -p 5432:5432 -p 10110:10110 osiamorg/osiam:2.5

or in daemon mode with:

    $ docker run -d -p 8080:8080 -p 5432:5432 -p 10110:10110 osiamorg/osiam:2.5

This will bind ports 8080 (tomcat), 5432 (postgres) and 10110 (greenmail) on
the docker host.

Access database with

    ong:b4s3dg0d

access OSIAM with

    admin:koala

See [Next Steps](https://github.com/osiam/osiam/blob/v2.5/docs/detailed-reference-installation.md#next-steps)
chapter in official docs how to use OSIAM.

### Debug

To enable tomcat debugging, set the `DEBUG` environment variable to any value.

For example, add this to the `run` command:

    -e "DEBUG=true"

## Build

The build process will checkout the OSIAM sources from GitHub and then build the
WARs and configure Tomcat appropriately. The file `build.conf` contains the
configuration of the repos and refs used to checkout the OSIAM sources. You can
build the image with:

    $ ./build

You can add arbitrary options, that are known to `docker build`, to this command
like: 

    $ ./build --no-cache

## Mail server

You do not need to change anything if you like to send e-mails via the
self-administration or administration. You can get the e-mails on the exposed
pop3 port 10110. This is helpful if you like to register a user and want to
activate him with the generated link which is sent with the e-mail. Here is an
example how to get e-mails with telnet:

Login to the greenmail server via telnet on your locale machine

    $ telnet localhost 10110
    
Use the e-mail address of the user

    USER e-mail address e.g. hello@osiam.org
    PASS e-mail address e.g. hello@osiam.org
    
List all messages

    LIST

Show message with ID 1

    RETR 1

## Stuff that does not work (TODOs)

* setting db password and other security stuff on run
* convenient retrieval of server logs
* persisting data in external bind-mounted volume
* externalizing configuration in external bind-mounted volume
* making image suitable for production deployment
