# GOSH's Caddy build with Cloudflare tls

## Setup

1. Create new token https://dash.cloudflare.com/profile/api-tokens

Give your token a descriptive name (e.g. Caddy), and add 2 permissions:
- Zone - Zone - Read
- Zone - DNS - Edit

2. `./caddy_cf_token`
```env
CF_TOKEN=...
```

3. `caddy/Caddyfile`
```
https://example.com {
        tls {
                dns cloudflare {env.CF_TOKEN}
                resolvers 1.1.1.1
        }
        ...
}
```

4. `./compose.yaml`
```yaml
networks:
  my-net:
    external: true

services:
  caddy:
    image: teamgosh/caddy
    container_name: caddy
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    env_file: ${PWD}/caddy_cf_token
    volumes:
      - ./caddy:/etc/caddy
      - ./data:/data
      - ./www:/var/www
    restart: unless-stopped
    networks:
      - my-net
```

5. Turn on "Proxied" in Cloudflare's DNS Dashboard
