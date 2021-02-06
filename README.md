# Docker-php

HDCore extended docker images for automatic CI testing

For use in Dockerfile or docker-compose.yml

```
FROM hdcore/docker-php:8.0
FROM hdcore/docker-php:7.4
```

# Custom scripts

## Show version

```bash
buildversion.sh
```

## Import SSH private key

```bash
. addsshkey.sh
```

## Add custom CA certificates

```bash
. addcacerts.sh
```

## Configure proxy for git

```bash
addgitproxy.sh
```

# Testing

## Test all images

```bash
docker-compose build
```

## Test one image

```bash
docker build -t <imagename> -f <path>/Dockerfile .
docker run --rm -it <imagename> /bin/bash
```