# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
# GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000 \
      APP_VERSION=3.22

 # :: FOREIGN IMAGES
  FROM 11notes/util:bin AS util

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
# :: HEADER
  FROM alpine:${APP_VERSION}

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: app specific environment  
    ENV APORTS=${APP_ROOT}/.aports

  # :: multi-stage
    COPY --from=util /usr/local/bin /usr/local/bin

  # :: setup
    RUN set -ex; \
      apk --no-cache --update add \
        ca-certificates \
        tini \
        curl \
        tzdata \
        shadow \
        alpine-conf \
        alpine-sdk \
        ccache \
        git \
        doas;

    RUN set -ex; \
      addgroup --gid 1000 -S docker; \
      adduser --uid 1000 -D -S -h ${APP_ROOT} -s /sbin/nologin -G docker docker;

    RUN set -ex; \
      mkdir -p ${APORTS}; \
      mkdir -p /apk; \
      mkdir -p /src; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /apk \
        /src; \
      apk update;

    RUN set -ex; \
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

    COPY ./rootfs /
    
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

# :: EXECUTE
  USER docker