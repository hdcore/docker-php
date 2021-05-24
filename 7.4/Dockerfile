# HDCore extended docker images
ARG VERSION=7.4
FROM php:${VERSION}
ARG VERSION

# Labels
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "maintainer"="HDCore"
LABEL "org.opencontainers.image.ref.name"="hdcore/docker-php:${VERSION}"
LABEL "org.opencontainers.image.title"="HDCore extended php image for ${PHP_VERSION}"
LABEL "org.opencontainers.image.source"="https://github.com/hdcore/docker-php"
LABEL "org.opencontainers.image.url"="https://hub.docker.com/repository/docker/hdcore/docker-php"

# Possible Environment variables
# ENV SSH_PRIVATE_KEY
# ENV CACERT_FILE_xxx

# Workdir
WORKDIR /workdir

# Copy scripts and add to the path
COPY ./scripts/* /usr/local/bin/hdcore/
RUN chmod +x /usr/local/bin/hdcore/*.sh
ENV PATH="/usr/local/bin/hdcore:${PATH}"

# Add proxy on build time
ARG http_proxy
ARG HTTP_PROXY
RUN set-proxy.sh

# Install git, zip, unzip, openssh, libzip, gd2
RUN apt-get update -yqq \
    && apt-get install git zip unzip openssh-client libzip-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev -yqq \
    && rm -rf /var/lib/apt/lists/*

# PHP extension pdo_mysql zip gd2
RUN docker-php-ext-install pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install SNMP
#RUN apt-get update -yqq && apt-get install snmp snmpd libsnmp-dev -yqq && rm -rf /var/lib/apt/lists/* && docker-php-ext-install snmp

# Install LDAP
#RUN apt-get update -yqq && apt-get install libldap2-dev -y && rm -rf /var/lib/apt/lists/* && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && docker-php-ext-install ldap

# PHP PCov (faster than xdebug for coverage only)
RUN pecl install pcov && docker-php-ext-enable pcov && echo 'pcov.directory=.' >> /usr/local/etc/php/conf.d/docker-php-ext-pcov.ini

# PHP Xdebug
#RUN pecl install xdebug && docker-php-ext-enable xdebug

# Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# PHPUnit
RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/local/bin/phpunit

# Image build details
RUN echo "Build date: $(date)\nPHP version: $PHP_VERSION" > /var/log/hdcore-image.log

#RUN useradd -s /bin/bash phpcmd
#USER phpcmd

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
