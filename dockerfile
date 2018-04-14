# ----------------------------------
# Mount & Blade Warband
# Napoleonic Wars Dockerfile
# Environment: Ubuntu:16.04 - Wine + M&B Warband
# Minimum Panel Version: 0.7.6
# ----------------------------------
FROM        ubuntu:16.04

MAINTAINER  Mason Rowe, <mason@masonrowe.com>
ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt update \
            && apt upgrade -y \
            && apt install -y wget software-properties-common apt-transport-https bsdtar \
            && wget -qO - https://dl.winehq.org/wine-builds/Release.key | apt-key add - \
            && apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ \
            && apt install -y --install-recommends winehq-stable \
            && apt clean \
            && useradd -m -d /home/container container \
            && cd /home/container \
            && wget -qO- www.fsegames.eu/mb_warband_napoleonic_wars_dedicated_1173_nw_1200.zip | bsdtar -xvf- --strip-components=1

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
