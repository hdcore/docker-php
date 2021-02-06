# HDCore extended docker images
ARG VERSION=8.0
FROM php:${VERSION}
ARG VERSION

# Labels
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "maintainer"="HDCore"
LABEL "org.opencontainers.image.ref.name"="hdcore/docker-php:${VERSION}"
LABEL "org.opencontainers.image.title"="HDCore extended php image for ${PHP_VERSION}"
LABEL "org.opencontainers.image.source"="https://github.com/hdcore/docker-php"
LABEL "org.opencontainers.image.url"="https://hub.docker.com/repository/docker/hdcore/docker-php"

# Environment variables
# ENV SSH_PRIVATE_KEY

# Workdir
WORKDIR /workdir

# Copy scripts and add to the path
COPY ./scripts/* /usr/local/bin/hdcore/
RUN chmod +x /usr/local/bin/hdcore/*.sh
ENV PATH="/usr/local/bin/hdcore:${PATH}"

# Install git, zip, unzip and openssh
RUN apt-get update -yqq \
    && apt-get install git zip unzip openssh-client -yqq \
    && rm -rf /var/lib/apt/lists/*

# PHP extension pdo_mysql
RUN docker-php-ext-install pdo_mysql

# PHP extension zip
RUN apt-get update -yqq \
    && apt-get install libzip-dev -yqq \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip

# Install gd2
RUN apt-get update -yqq \
    && apt-get install libfreetype6-dev libjpeg62-turbo-dev libpng-dev -yqq \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install SNMP
#RUN apt-get update -yqq && apt-get install snmp snmpd libsnmp-dev -yqq && rm -rf /var/lib/apt/lists/* && docker-php-ext-install snmp

# Install LDAP
#RUN apt-get update -yqq && apt-get install libldap2-dev -y && rm -rf /var/lib/apt/lists/* && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && docker-php-ext-install ldap

# PHP PCov (faster than xdebug for coverage only)
RUN pecl install pcov && docker-php-ext-enable pcov && echo 'pcov.directory=.' >> /usr/local/etc/php/conf.d/docker-php-ext-pcov.ini

# PHP Xdebug
# PECL was originally been removed from PHP 8.0-rc0, but came back later
#RUN pecl install xdebug && docker-php-ext-enable xdebug
# Workaround for PHP 8.0rc0
#RUN mkdir -p /usr/src/php/ext/xdebug && curl -fsSL https://pecl.php.net/get/xdebug | tar xvz -C "/usr/src/php/ext/xdebug" --strip 1 && docker-php-ext-install xdebug

# Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# PHPUnit
RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/local/bin/phpunit

# Version
RUN echo "Build date: $(date)\nPHP version: $PHP_VERSION" > /var/log/buildversion.log && buildversion.sh
