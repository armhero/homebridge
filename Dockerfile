FROM armhero/nodejs
MAINTAINER Simon Erhardt <hello@rootlogin.ch>

ARG UID=1506
ARG GID=1506

COPY root /

RUN apk add --update \
  alpine-sdk \
  avahi \
  avahi-compat-libdns_sd \
  avahi-dev \
  bash \
  python \
  tini \
  && addgroup -g ${GID} homebridge \
  && adduser -u ${UID} -h /opt/homebridge -H -G homebridge -s /bin/bash -D homebridge \
  && npm install -g homebridge \
  && apk del \
  alpine-sdk \
  avahi-dev \
  && chmod +x /usr/local/bin/*.sh \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /var/run/dbus

EXPOSE 5353 51826

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/local/bin/run-container.sh"]
