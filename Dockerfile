# ----------------------------------
# Holdfast: Nations at War Dockerfile
# Environment: Ubuntu:16.04 + Wine + Xvfb
# Minimum Panel Version: 0.7.9
# ----------------------------------
FROM        ubuntu:18.04

MAINTAINER  Mason Rowe, <mason@rowe.sh>
ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt update \
            && apt upgrade -y \
            && apt install -y wget software-properties-common apt-transport-https bsdtar dos2unix xvfb \
            && wget -qO - https://dl.winehq.org/wine-builds/Release.key | apt-key add - \
            && apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ \
            && apt update \
            && apt install -y --install-recommends winehq-stable \
            && apt install -y winetricks \
            && apt clean \
            && winetricks sound=disabled \
            && mkdir -p /tmp/.X11-unix \
            && chmod 1777 /tmp/.X11-unix \
            && chown root:root /tmp/.X11-unix \
            && Xvfb :0 -screen 0 1024x768x16 & \
            && useradd -m -d /home/container container \
            && cd /home/container

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
