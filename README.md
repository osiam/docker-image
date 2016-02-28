# OSIAM Docker Image

This project builds a docker image with OSIAM installed and configured ready to 
use for development purposes. **WARNING:** This image is for development purposes 
only! Do not even think about using it in a production-like environment!

## Installation details

* includes OSIAM, addon-self-administration,
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

    osiam:osiam

access OSIAM with

    admin:koala

See [Next Steps](https://github.com/osiam/osiam/blob/v2.4/docs/detailed-reference-installation.md#next-steps)
chapter in official docs how to use OSIAM.

### Accessing the Logs

You can find the log files in the container file system:

```
/var/log/supervisor/tomcat8-stderr---supervisor-EQxqwo.log
/var/log/supervisor/tomcat8-stdout---supervisor-Vcz9Yi.log
```

The cryptic suffix is, of course, a random string, so the files have other names in your container.

### Debug

You can also start Tomcat in debugging mode.
Set the `DEBUG` environment variable to any value and expose the default debugging port `8000`.
For example, add this to the `run` command:

    -e "DEBUG=true" -p 8000:8000

You can now attach a debugger to `localhost:8000` and debug the OSIAM services.

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

## Use with docker-machine

This container will only work with docker-machine (or boot2docker) when
forwarding the port of the tomcat that is running inside the docker container.
This solution is actually usable for any other set-up where the container is
not running on the host system directly. The trick is to forward the tomcat
port via ssh tunnel to the host

    $ docker-machine ssh default -L 8080:localhost:8080

This example assumes that there is a docker machine called `default`. If you
want to use this with a VM, just use the ssh command and change `default` to
the remote host/ip.

## Stuff that does not work (TODOs)

* setting db password and other security stuff on run
* convenient retrieval of server logs
* persisting data in external bind-mounted volume
* externalizing configuration in external bind-mounted volume
* making image suitable for production deployment
