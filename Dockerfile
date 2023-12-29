# syntax=docker/dockerfile:1.6.0

ARG CADDY_VERSION=2.7.6

FROM caddy:${CADDY_VERSION}-builder AS caddy-builder

# add cloudflare DNS TLS support
# see: https://roelofjanelsinga.com/articles/using-caddy-ssl-with-cloudflare/
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}-alpine
COPY --from=caddy-builder /usr/bin/caddy /usr/bin/caddy
