![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# ⛰️ apk
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-apk)![size](https://img.shields.io/docker/image-size/11notes/apk/3.21?color=0eb305)![version](https://img.shields.io/docker/v/11notes/apk/3.21?color=eb7a09)![pulls](https://img.shields.io/docker/pulls/11notes/apk?color=2b75d6)[<img src="https://img.shields.io/github/issues/11notes/docker-apk?color=7842f5">](https://github.com/11notes/docker-apk/issues)

Build Alpine apk, quick and easy

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [3.21](https://hub.docker.com/r/11notes/apk/tags?name=3.21)
* [stable](https://hub.docker.com/r/11notes/apk/tags?name=stable)
* [latest](https://hub.docker.com/r/11notes/apk/tags?name=latest)

# SYNOPSIS 📖
**What can I do with this?** This image will let you build your own custom apk’s for Alpine in a self-containing and easy manner. Simply add all the projects you want to build to the ```/src``` directory and execute ```amake```. This will create all your apk’s and put them into ```/apk``` for user in other layers or to export them. You can also sparse checkout and build official packages from different releases by simply calling ```amake python3 main 3.18``` which would build python3 in the latest version of [Alpine 3.18](https://pkgs.alpinelinux.org/package/v3.18/main/x86_64/python3) from the main branch. Since this is a sparse checkout, it will only download the python3 folder in question and not the entire aports repo, which makes for very quick builds.

# BUILD 🚧
```yaml
FROM 11notes/apk:stable AS build
# build your apk
RUN set -ex; \
  amake python3 main 3.19

FROM 11notes/alpine:stable
# copy apk
COPY --from=build /apk/ /apk
# install custom apk
RUN set -ex; \
  apk --no-cache --allow-untrusted --repository /apk add \
    python3=~3.11; \
  rm -rf /apk;
```

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | /build | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |

# SOURCE 💾
* [11notes/apk](https://github.com/11notes/docker-apk)

# PARENT IMAGE 🏛️
* [11notes/alpine:3.21](https://hub.docker.com/r/11notes/alpine)

# BUILT WITH 🧰
* [alpine](https://www.alpinelinux.org/)

# GENERAL TIPS 📌
* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# SECURITY VULNERABILITIES REPORT ⚡
| Severity | Package | Version | Fix Version | Type | Location | Data Namespace | Link |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4.7 (Medium) | linux-pam  | 1.6.1-r1  |   | apk  | /lib/apk/db/installed  | nvd:cpe  | [CVE-2024-10041](https://nvd.nist.gov/vuln/detail/CVE-2024-10041)  |


# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-apk/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-apk/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-apk/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created Thu, 20 Feb 2025 13:52:05 GMT*