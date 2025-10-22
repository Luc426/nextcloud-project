FROM php:8.3-fpm-alpine

# Nginx and PHP require the same web repository absolute path:
RUN mkdir -p /usr/share/nginx/html

ENV OLDPWD=/usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Install temporary build libs required by PHP extensions: 
RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        git \
        unzip \
        freetype-dev \
        libwebp-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        samba-dev \
        icu-dev \
        libxml2-dev \
        gettext-dev \
        gmp-dev \
        krb5-dev \
        imap-dev \
        imagemagick-dev \
        bzip2-dev \
        curl-dev \
        openldap-dev \
        openssl-dev \
        oniguruma-dev \
        postgresql-dev

# Install system runtimes for PHP extensions: 
RUN apk add --no-cache \
    aom-libs \
    avahi-libs \
    c-ares \
    cairo \
    cups-libs \
    c-client \
    dbus-libs \
    ffmpeg \
    fftw-double-libs \
    fontconfig \
    freetype \
    fribidi \
    gdbm \
    gdk-pixbuf \
    ghostscript \
    glib \
    gettext \
    gmp \
    gnutls \
    graphite2 \
    harfbuzz \
    icu-data-en \
    icu-libs \
    imagemagick \
    imagemagick-heic \
    imagemagick-jpeg \
    imagemagick-libs \
    imagemagick-pango \
    imagemagick-pdf \
    imagemagick-raw \
    imagemagick-svg \
    imagemagick-tiff \
    imagemagick-webp \
    jbig2dec \
    lcms2 \
    libblkid \
    libbsd \
    libbz2 \
    libdav1d \
    libde265 \
    libeconf \
    libexpat \
    libffi \
    libgcc \
    libgomp \
    libheif \
    libice \
    libintl \
    libjpeg-turbo \
    libldap \
    libltdl \
    libmd \
    libmemcached-libs \
    libmount \
    libpng \
    libpq \
    libpsl \
    libraw \
    librsvg \
    libsharpyuv \
    libsm \
    libstdc++ \
    libtasn1 \
    libuuid \
    libwebp \
    libwebpdemux \
    libwebpmux \
    libx11 \
    libxau \
    libxcb \
    libxdmcp \
    libxext \
    libxft \
    libxrender \
    libxt \
    libxxhash \
    libwebp \
    libzip \
    lz4-libs \
    ncurses-terminfo-base \
    nettle \
    nghttp2-libs \
    numactl \
    openjpeg \
    openssl \
    p11-kit \
    pango \
    pcre2 \
    gmp \
    libgomp \
    pixman \
    pkgconf \
    popt \
    rsync \
    scanelf \
    shared-mime-info \
    sqlite-libs \
    samba \
    ssl_client \
    tar \
    tiff \
    x265-libs
    
# Configur GD using freetype + jpeg:
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-configure ldap --with-libdir=lib \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install \
        gd \
        zip \
        bz2 \
        intl \
        mbstring \
        fileinfo \
        ftp \
        pcntl \
        mysqli \
        bcmath \
        gettext \
        ldap \
        imap \
        exif \
        gmp \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        sysvsem \
        xml \
        curl

# Install PECL extensions :
RUN pecl install redis imagick apcu smbclient \
    && docker-php-ext-enable redis imagick apcu smbclient

# Clean build dependances and lighten the final Docker image:
RUN apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/pear ~/.pearrc