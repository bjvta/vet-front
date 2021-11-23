FROM alpine:latest as base

ENV LANG="C.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_COLLATE=C \
    DEBIAN_FRONTEND=noninteractive \
    TERM="xterm-256color"

RUN set -eux \
# Packages from testing
    && apk add \
        --no-cache \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
# Docker tools
        gosu \
        tini

RUN set -eux \
    && apk add \
        --no-cache  \
# Common tools for development and building
        bash

RUN set -eux \
    && apk add \
        --no-cache  \
        nodejs-current \
        yarn

# Setup non-root user
RUN set -eux \
    \
    && addgroup -g 1000 app \
    && adduser -u 1000 -G app -H -D app \
    \
    && mkdir -p /app \
    && chown -R app /app

WORKDIR "/app"

COPY entrypoint-production.sh /sbin/docker-entrypoint.sh

ENTRYPOINT ["tini", "--", "/sbin/docker-entrypoint.sh"]

EXPOSE 3000

CMD ["--shell"]

FROM base as frontend

ENV ENVIRONMENT=develop

RUN set -eux \
    && apk add \
        --no-cache \
# Common tools for development and building
        make

COPY ./skel /etc/skel

RUN set -eux \
    && mkdir /home/app \
    && chown app:app -R /home/app \
    && gosu app cp -R /etc/skel/. /home/app/

VOLUME /home/app

COPY entrypoint-frontend.sh /sbin/docker-entrypoint.sh

CMD ["--shell"]