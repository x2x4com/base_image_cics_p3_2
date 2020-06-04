# PHP 容器配置

# 从官方基础版本构建
FROM php:7.1-fpm
# 官方版本默认安装扩展: 
# Core, ctype, curl
# date, dom
# fileinfo, filter, ftp
# hash
# iconv
# json
# libxml
# mbstring, mysqlnd
# openssl
# pcre, PDO, pdo_sqlite, Phar, posix
# readline, Reflection, session, SimpleXML, sodium, SPL, sqlite3, standard
# tokenizer
# xml, xmlreader, xmlwriter
# zlib

# 1.0.2 增加 bcmath, calendar, exif, gettext, sockets, dba, 
# mysqli, pcntl, pdo_mysql, shmop, sysvmsg, sysvsem, sysvshm 扩展
RUN docker-php-ext-install -j$(nproc) bcmath calendar exif gettext \
sockets dba mysqli pcntl pdo_mysql shmop sysvmsg sysvsem sysvshm

# Use tingwa mirrors
RUN curl https://gitee.com/x2x4/mytools/raw/master/debian/apt/buster/sources.list -o /etc/apt/sources.list && \
apt-get update && \
apt-get install -y libbz2-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev firebird-dev freetds-dev libxml2-dev libtidy-dev libxslt1-dev libzip-dev libgmp-dev libsnmp-dev libpq-dev libpspell-dev librecode-dev libkrb5-dev firebird-dev libicu-dev libmcrypt-dev libldap2-dev libmagickwand-dev zlib1g-dev libmemcached-dev libmagickwand-dev

# 1.0.3 增加 bz2 扩展, 读写 bzip2（.bz2）压缩文件
RUN docker-php-ext-install -j$(nproc) bz2 && \
# 1.0.4 增加 enchant 扩展, 拼写检查库
# apt-get install -y --no-install-recommends libenchant-dev && \
# docker-php-ext-install -j$(nproc) enchant && \
# 1.0.5 增加 GD 扩展. 图像处理
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
docker-php-ext-install -j$(nproc) gd && \
# 1.0.6 增加 gmp 扩展, GMP
docker-php-ext-install -j$(nproc) gmp && \
# 1.0.7 增加 soap wddx xmlrpc tidy xsl 扩展
docker-php-ext-install -j$(nproc) soap wddx xmlrpc tidy xsl && \
# 1.0.8 增加 zip 扩展
docker-php-ext-install -j$(nproc) zip && \
# 1.0.9 增加 snmp 扩展
docker-php-ext-install -j$(nproc) snmp && \
# 1.0.10 增加 pgsql, pdo_pgsql 扩展 
docker-php-ext-install -j$(nproc) pgsql pdo_pgsql && \
# 1.0.11 增加 pspell 扩展 
docker-php-ext-install -j$(nproc) pspell && \
# 1.0.12 增加 recode 扩展 
docker-php-ext-install -j$(nproc) recode && \
# 1.0.13 增加 PDO_Firebird 扩展 
docker-php-ext-install -j$(nproc) pdo_firebird && \
# 1.0.14 增加 pdo_dblib 扩展 
docker-php-ext-configure pdo_dblib --with-libdir=lib/x86_64-linux-gnu && \
docker-php-ext-install -j$(nproc) pdo_dblib && \
# 1.0.15 增加 ldap 扩展 
docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
docker-php-ext-install -j$(nproc) ldap && \
# 1.0.16 增加 imap 扩展 
# docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
# docker-php-ext-install -j$(nproc) imap && \
# 1.0.17 增加 interbase 扩展 
docker-php-ext-install -j$(nproc) interbase && \
# 1.0.18 增加 intl 扩展 
docker-php-ext-install -j$(nproc) intl && \
# 1.0.19 增加 mcrypt 扩展 
# pecl install mcrypt-1.0.1 && \
# docker-php-ext-enable mcrypt && \
# 1.0.20 imagick 扩展
export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
pecl install imagick-3.4.3 && \
docker-php-ext-enable imagick && \
# 1.0.21 增加 Memcached 扩展 
pecl install memcached && \
docker-php-ext-enable memcached && \
# 1.0.22 redis 扩展
pecl install redis-4.0.1 && docker-php-ext-enable redis && \
# 1.0.23 增加 opcache 扩展 
docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache && \
rm -r /var/lib/apt/lists/*

