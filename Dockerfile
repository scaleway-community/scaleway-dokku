## -*- docker-image-name: "scaleway/dokku:latest" -*-
FROM scaleway/docker:amd64-latest
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/docker:armhf-latest	# arch=armv7l
#FROM scaleway/docker:arm64-latest	# arch=arm64
#FROM scaleway/docker:i386-latest	# arch=i386
#FROM scaleway/docker:mips-latest	# arch=mips


# Prepare rootfs for image-builder
RUN /usr/local/sbin/scw-builder-enter


# Upgrade system and install packages
RUN echo "Configure aptitude"                                      \
 && wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -  \
 && echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | tee /etc/apt/sources.list.d/dokku.list  \
 && apt-get update -qq                                             \
 && echo "Install herokuish"                                       \
 && apt-get download herokuish                                     \
 && dpkg --unpack herokuish*.deb                                   \
 && rm /var/lib/dpkg/info/herokuish.postinst                       \
 && dpkg --configure herokuish                                     \
 && apt-get install -yf                                            \
 && apt-get clean                                                  \
 && rm -f herokuish*.deb                                           \
 && echo "Install Dokku"                                           \
 && apt-get -q -y install dokku                                    \
 && apt-get clean


# Configure env for docker inheriting (not used by this Dockerfile)
ENV DOKKU_TAG=v0.4.14


# Patch rootfs
#ADD ./overlay/ /


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
