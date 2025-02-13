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