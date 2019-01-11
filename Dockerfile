# ----------------------------------
# Holdfast: Nations at War Dockerfile
# Environment: Ubuntu:18.04 + Wine + Xvfb
# Minimum Panel Version: 0.7.9
# ----------------------------------
FROM        ubuntu:18.04
LABEL       author="Mason Rowe" maintainer="mason@rowe.sh"
ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         apt update \
            && apt upgrade -y \
            && apt install -y iproute2 ca-certificates xvfb lib32gcc1 libntlm0 winbind wine64 winetricks --install-recommends \
            && apt clean \

USER        container
ENV         USER=container HOME=/home/container WINEARCH=win64 WINEPREFIX=/home/container/.wine64
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
