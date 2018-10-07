FROM centos:centos7

# make sure that the only yum repository used is the one in artifactory
RUN    dbus-uuidgen > /var/lib/dbus/machine-id

# install the packages from artifactory
ENV    PKGS=" wget \
              less \
              unzip \
              which \
              tar \
              java-1.8.0-openjdk-devel \
              maven-3.3.1-vn.1 \
              firefox \
              libcanberra-gtk2 \
              xorg-x11-server-Xvfb \
              PyYAML \
          "

# install and validate packages
RUN     yum install -y $PKGS && \
        for pkg in $PKGS ; do if [ "$(rpm -q $pkg | grep not | wc -l)" -ne "0" ] ; then echo "$pkg was not installed" ; exit -1; fi ; done && \
        yum clean all

ENV RUNNER_DIR /usr/local/share

#
# Download Jystem  to docker container
#
RUN	wget <Jsystem Runner ZIP File> && \
 	unzip <Jsystem Runner ZIP File> -d $RUNNER_DIR &&\
	rm -f <Jsystem Runner ZIP File>

ENV RUNNER_HOME $RUNNER_DIR/jsystem/runner

##
# copy files to replace
##
COPY FilesToReplace/* $RUNNER_HOME/

# add the special user to run under with specific uid and gid
RUN     groupadd -g 1000 jenkins
RUN     useradd -u 1000 -g 1000 jenkins
ENV     USER jenkins

RUN     chown -R jenkins:jenkins /usr/local/share/jsystem
USER    jenkins
