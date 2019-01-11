# ----------------------------------
# Holdfast: Nations at War Dockerfile
# Environment: Ubuntu:18.04 + Wine + Xvfb
# Minimum Panel Version: 0.7.9
# ----------------------------------
FROM        ubuntu:18.04

MAINTAINER  Mason Rowe, <mason@rowe.sh>
ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         apt update \
            && apt upgrade -y \
            && apt install -y iproute2 xvfb lib32gcc1 libntlm0 winbind wine64 winetricks --install-recommends \
            && apt clean \
            && useradd -m -d /home/container container \
            && cd /home/container

USER        container
ENV         HOME /home/container
ENV         WINEARCH win64
ENV         WINEPREVIX /home/container/.wine64
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
