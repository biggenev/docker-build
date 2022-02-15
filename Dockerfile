#Download base image ubuntu
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="na.ev.dm@gmail.com"
LABEL version="0.5"

ENV TZ=Europe/Moscow

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get -y update \
    && apt-get -y install apache2 \
    && apt-get -y install git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/biggenev/mysite.git \
    && cp -a /mysite/. /var/www/html

COPY 000-default.conf /etc/apache2/sites-available

RUN a2enmod ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/apache2.key -out  /etc/apache2/apache2.cert -subj "/C=GB/ST=Moscow/L=Moscow/O=Global Security/OU=IT Department/CN=nakoskinevgeniy.ru"

CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]

EXPOSE 80 443 
