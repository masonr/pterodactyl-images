# Docker image for Holdfast: Nations At War servers within Pterodactyl Panel

## Automated Builds

This Docker image is automatically built and can be found on the Docker Hub at:  
https://hub.docker.com/r/masonr/pterodactyl-images/

To pull the pre-built Docker image:  
```bash
$ docker pull masonr/pterodactyl-images:holdfast
```

## Important Notes

* You must own Holdfast: Nations At War on Steam in order to download the server files.
* Adding the Steam password is optional, but Steam username is necessary. If password is left blank, you will need to input your password and 2FA code (if enabled) on server startup.
* Requires at least 16 GB of disk per instance.

## Required Server Ports

Holdfast requires three ports:

| Port    | default | (acceptable range) |
|---------| ------- | ------------------ |
| Game    | 20100   | 20100-20300        |
| Comm    | 8700    | 8700-8900          |
| Query   | 27000   | 27000-29000        |

## License
```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2018 Mason Rowe <mason@rowe.sh>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
