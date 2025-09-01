ARG APP_VERSION=stable

# :: Util
  FROM 11notes/util AS util

# :: Header
  FROM 11notes/alpine:${APP_VERSION}

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

    ENV APORTS=${APP_ROOT}/.aports

  # :: multi-stage
    COPY --from=util /usr/local/bin/ /usr/local/bin

# :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      apk --no-cache --update add \
        shadow \
        alpine-conf \
        alpine-sdk \
        ccache \
        git \
        doas;

    RUN set -ex; \
      mkdir -p ${APORTS}; \
      mkdir -p /apk; \
      mkdir -p /src; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /apk \
        /src;

  # :: install application
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

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

# :: Start
  USER docker