FROM armhero/nodejs
MAINTAINER Simon Erhardt <hello@rootlogin.ch>

ARG UID=1506
ARG GID=1506

COPY root /

RUN apk add --update \
  bash \
  python \
  tini \
  && addgroup -g ${GID} homebridge \
  && adduser -u ${UID} -h /opt/homebridge -H -G homebridge -s /bin/bash -D homebridge \
  && npm install -g homebridge \
  && chmod +x /usr/local/bin/run-container.sh \
  && rm -rf /var/cache/apk/*

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/local/bin/run-container.sh"]
