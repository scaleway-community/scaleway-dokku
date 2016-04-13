NAME =			dokku
VERSION =		latest
VERSION_ALIASES =	
TITLE =			Dokku
DESCRIPTION =		Dokku
SOURCE_URL =		https://github.com/scaleway-community/scaleway-dokku
IMAGE_DEFAULT_ARCH =	x86_64


IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	docker
IMAGE_NAME =		Dokku


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
## Below you can add custom Makefile commands and overrides
