#!/usr/bin/env bash

set -eu

cat /etc/nginx/conf.d/default.conf

envsubst --verbose '${NGINX_PORT=80} ${RESOLVER_IP=127.0.0.11} ${UPSTREAM_HOST=php} ${UPSTREAM_PORT=9000}' </etc/nginx/conf.d/default.template.conf >/etc/nginx/conf.d/default.conf

sed -i '/resolver ;/d' /etc/nginx/conf.d/default.conf

exec "$@"
