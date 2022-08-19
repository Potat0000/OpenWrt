#!/bin/sh /etc/rc.common

PROG=/usr/bin/AdGuardHome
WORK_DIR=/etc/adguardhome
CONFIG_DIR=/etc/adguardhome.yaml

USE_PROCD=1

# starts after network starts
START=21
# stops before networking stops
STOP=89

start_service() {
  [ -d "$WORK_DIR" ] || mkdir -m 0755 -p "$WORK_DIR"

  procd_open_instance
  procd_set_param command "$PROG" -c "$CONFIG_DIR" -w "$WORK_DIR" --no-check-update
  procd_set_param stdout 1
  procd_set_param stderr 1
  procd_close_instance
}
