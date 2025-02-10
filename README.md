![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ apk
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-apk)![size](https://img.shields.io/docker/image-size/11notes/apk/3.21?color=0eb305)![version](https://img.shields.io/docker/v/11notes/apk/3.21?color=eb7a09)![pulls](https://img.shields.io/docker/pulls/11notes/apk?color=2b75d6)[<img src="https://img.shields.io/github/issues/11notes/docker-apk?color=7842f5">](https://github.com/11notes/docker-apk/issues)

**Build Alpine apk on the fly**

# SYNOPSIS 📖
**What can I do with this?** This image will let you build your own custom apk’s for Alpine in a self-containing and easy manner. Simply add all the projects you want to build to the ```/src``` directory and execute ```amake```. This will create all your apk’s and put them into ```/apk``` for further use. This image provides a sparse checkout of aports from Alpine under /build/.aports. You can also sparse checkout and build official packages from different releases by simply calling ```amake python3 3.18``` which would build python3 in the latest version of [Alpine 3.18](https://pkgs.alpinelinux.org/package/v3.18/main/x86_64/python3).

# SOURCE 💾
* [11notes/apk](https://github.com/11notes/docker-apk)

# PARENT IMAGE 🏛️
* [11notes/alpine:3.21](https://hub.docker.com/r/11notes/alpine)

# BUILT WITH 🧰
* [alpine](https://alpinelinux.org)

# GENERAL TIPS 📌
* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services
  
# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-apk/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-apk/issues), thanks. You can find all my repositories on [github](https://github.com/11notes?tab=repositories).