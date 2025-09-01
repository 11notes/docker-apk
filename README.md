![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# APK
![size](https://img.shields.io/docker/image-size/11notes/apk/3.22?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/11notes/apk/3.22?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/11notes/apk?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/11notes/docker-APK?color=7842f5">](https://github.com/11notes/docker-APK/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxyZWN0IHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgZmlsbD0idHJhbnNwYXJlbnQiLz4KICA8cGF0aCBkPSJtMTMgNmg2djdoN3Y2aC03djdoLTZ2LTdoLTd2LTZoN3oiIGZpbGw9IiNmZmYiLz4KPC9zdmc+)

Build Alpine apk, quick and easy

# SYNOPSIS 📖
**What can I do with this?** This image will let you build your own custom apk’s for Alpine in a self-containing and easy manner. Simply add all the projects you want to build to the ```/src``` directory and execute ```amake```. This will create all your apk’s and put them into ```/apk``` for use in other layers or to export them. You can also sparse checkout and build official packages from different releases by simply calling ```amake python3 main 3.18``` which would build python3 in the latest version of [Alpine 3.18](https://pkgs.alpinelinux.org/package/v3.18/main/x86_64/python3) from the main branch. Since this is a sparse checkout, it will only download the python3 folder in question and not the entire aports repo, which makes for very quick builds.

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

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [3.22](https://hub.docker.com/r/11notes/apk/tags?name=3.22)
* [stable](https://hub.docker.com/r/11notes/apk/tags?name=stable)

### There is no latest tag, what am I supposed to do about updates?
It is of my opinion that the ```:latest``` tag is dangerous. Many times, I’ve introduced **breaking** changes to my images. This would have messed up everything for some people. If you don’t want to change the tag to the latest [semver](https://semver.org/), simply use the short versions of [semver](https://semver.org/). Instead of using ```:3.22``` you can use ```:3```. Since on each new version these tags are updated to the latest version of the software, using them is identical to using ```:latest``` but at least fixed to a major or minor version.

If you still insist on having the bleeding edge release of this app, simply use the ```:rolling``` tag, but be warned! You will get the latest version of the app instantly, regardless of breaking changes or security issues or what so ever. You do this at your own risk!

# REGISTRIES ☁️
```
docker pull 11notes/apk:3.22
docker pull ghcr.io/11notes/apk:3.22
docker pull quay.io/11notes/apk:3.22
```

# SOURCE 💾
* [11notes/apk](https://github.com/11notes/docker-APK)

# PARENT IMAGE 🏛️
* [alpine:3.22](${{ json_readme_parent_url }})

# BUILT WITH 🧰
* [alpine](https://www.alpinelinux.org/)
* [11notes/util](https://github.com/11notes/docker-util)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-apk/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-apk/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-apk/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 01.09.2025, 13:07:52 (CET)*