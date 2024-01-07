#!/bin/bash
set -ex
IFNAME=$1
THISHOST=$2
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
NETWORK=$(echo $ADDRESS | awk 'BEGIN {FS="."} ; { printf("%s.%s.%s", $1, $2, $3) }')

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
${NETWORK}.2  app-1.vagrant.local
${NETWORK}.3  app-2.vagrant.local
${NETWORK}.4  prometheus.vagrant.local
${NETWORK}.5  grafana.vagrant.local
${NETWORK}.6  grafana-loki.vagrant.local
EOF