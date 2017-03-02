#!/bin/bash

if [ -n "$PLUGINS" ]; then
  _PLUGINS=$(echo $PLUGINS | tr ";" "\n")
  for PLUGIN in $_PLUGINS
  do
      echo "Installing plugin: ${PLUGIN}"
      npm install -g ${PLUGIN}
  done
fi

if [ -f /var/run/dbus/pid ]; then
  rm /var/run/dbus/pid #incase shutdown abruptly
fi

sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

dbus-daemon --system
avahi-daemon -D

exec homebridge
