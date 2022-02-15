# Download base image ubuntu
FROM ubuntu:latest

# LABEL about the custom image
LABEL maintainer="na.ev.dm@gmail.com"
LABEL version="0.3"

ENV TZ=Europe/Moscow

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get -y update \
    && apt-get -y install apache2 \
    && apt-get -y install git \
	&& apt-get -y install snapd\
	&& rm -rf /var/lib/apt/lists/*

RUN snap install --classic certbot
	
COPY 000-default.conf /etc/apache2/sites-available

RUN git clone https://github.com/biggenev/mysite.git \
    && cp -a /mysite/. /var/www/html/
RUN a2enmod ssl
RUN certbot --email na.ev.dm@gmail.com --agree-tos --no-eff-email -d nakoskinevgeniy.ru -d www.nakoskinevgeniy.ru --apache

CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]

EXPOSE 80 443

