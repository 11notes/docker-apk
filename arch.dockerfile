# :: Util
  FROM alpine AS util

  RUN set -ex; \
    apk add --no-cache \
      git; \
    git clone -b stable https://github.com/11notes/docker-util.git;

# :: Header
  FROM 11notes/alpine:stable

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=util /docker-util/src /usr/local/bin

# :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}; \
      mkdir -p /apk; \
      mkdir -p /src;

  # :: install application
    RUN set -ex; \
      apk --no-cache --update add \
        alpine-sdk \
        git \
        doas; \
      addgroup docker wheel; \
      addgroup docker abuild; \
      mkdir -p /var/cache/distfiles; \
      chmod a+w /var/cache/distfiles; \
      chgrp abuild /var/cache/distfiles; \
      chmod g+w /var/cache/distfiles; \
      git config --global user.name "docker"; \
      git config --global user.email "docker@home.arpa";

    USER docker
      RUN set -ex; \
        abuild-keygen -a -n; 

    USER root
      RUN set -ex; \
        find ${APP_ROOT}/.abuild -name '*.pub' -exec cp "{}" /etc/apk/keys \;

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 \
        ${APP_ROOT};

# :: Start
  USER docker