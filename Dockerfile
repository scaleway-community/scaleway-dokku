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
RUN apt-get -q update                                                                                        \
 && apt-get --force-yes -y -qq upgrade                                                                       \
 && apt-get --force-yes install -y -q dokku                                                                  \
 && apt-get clean


# Patch rootfs
#ADD ./overlay/ /


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
