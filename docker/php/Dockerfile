FROM php:7.4-fpm-alpine

# 安装系统依赖
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    tzdata

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装PHP扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    gd \
    pdo_mysql \
    mysqli \
    zip \
    bcmath \
    opcache

# 安装Redis扩展
RUN pecl install redis && docker-php-ext-enable redis

# 复制PHP配置
COPY php.ini /usr/local/etc/php/
COPY php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# 安装Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 创建工作目录
WORKDIR /var/www/html

# 设置权限
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm"]