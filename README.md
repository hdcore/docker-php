# Docker-php

HDCore extended docker images for automatic CI testing

For use in Dockerfile or docker-compose.yml

```
FROM hdcore/docker-php:7.4

FROM hdcore/docker-php:8.0

FROM hdcore/docker-php:8.1
```

# FAQ

## Building the image

### Default

```bash
docker-compose build

docker-compose build local-php7.4-run

docker-compose build local-php8.0-run

docker-compose build local-php8.1-run
```

### Add proxy during build time only

```bash
docker image build . -f .\7.4\Dockerfile -t local-php7.4-run --build-arg http_proxy=http://proxy.url:8080 --rm --progress plain

docker image build . -f .\8.0\Dockerfile -t local-php8.0-run --build-arg http_proxy=http://proxy.url:8080 --rm --progress plain

docker image build . -f .\8.1\Dockerfile -t local-php8.1-run --build-arg http_proxy=http://proxy.url:8080 --rm --progress plain
```

## Running the image

### Default

```bash
docker-compose run --rm local-php7.4-run

docker-compose run --rm local-php8.0-run

docker-compose run --rm local-php8.1-run
```

### Add proxy on startup
- Add environment variable http_proxy.

### Add extra CA certificates on startup
- Add the *.crt to the /certificates/ folder.
- Add CACERT_FILE_XXXX environment variable who points to local filename

### Add extra SSH KEY
- Add environment variable SSH_PRIVATE_KEY

## Scripts

### Default
- /bin/bash
