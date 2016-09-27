## -*- docker-image-name: "scaleway/dokku:latest" -*-
FROM scaleway/ubuntu:amd64-trusty
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-trusty	# arch=armv7l
#FROM scaleway/ubuntu:arm64-trusty	# arch=arm64
#FROM scaleway/ubuntu:i386-trusty	# arch=i386
#FROM scaleway/ubuntu:mips-trusty	# arch=mips

MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/scw-builder-enter

# Install packages
RUN sed -i '/mirror.scaleway/s/^/#/' /etc/apt/sources.list \
 && apt-get -q update                   \
 && apt-get --force-yes -y -qq upgrade  \
 && apt-get --force-yes install -y -q   \
      apparmor                          \
      arping                            \
      aufs-tools                        \
      btrfs-tools                       \
      bridge-utils                      \
      cgroup-lite                       \
      git                               \
      ifupdown                          \
      kmod                              \
      lxc                               \
      make                              \
      python-setuptools                 \
      software-properties-common        \
      vlan                              \
 && apt-get clean


# Install docker
RUN curl -L https://get.docker.com/ | sh

# Configure env for docker inheriting (not used by this Dockerfile)
ENV DEBIAN_FRONTEND=noninteractive
ENV DOKKU_TAG=v0.7.2

# Install dokku from source
RUN cd /root                                                       \
 && git clone https://github.com/dokku/dokku.git                   \
 && cd dokku                                                       \
 && git fetch origin                                               \
 && git checkout $DOKKU_TAG                                        \
 && echo "Install Dokku"                                           \
 && CI="none" make install                                         \
 && apt-get clean


# Patch rootfs
#ADD ./overlay/ /

# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave

