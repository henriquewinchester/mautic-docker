FROM ubuntu:16.04

ENV PHP_VERSION 7.0
ENV MAUTIC_VERSION 2.13.0
ENV MAUTIC_HOME /var/www/html

RUN apt-get update \
    && apt-get install -y php7.0-fpm php7.0-mbstring php7.0-xml php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli php7.0-curl php7.0-zip apache2 php7.0 libapache2-mod-php7.0 php7.0-imap php7.0-intl php7.0-mcrypt curl unzip 

RUN rm -rfv ${MAUTIC_HOME}/*
ADD src/ ${MAUTIC_HOME}/
RUN chown -R www-data:www-data ${MAUTIC_HOME}
WORKDIR ${MAUTIC_HOME}

COPY config/mautic.conf /etc/apache2/sites-available/000-default.conf
COPY config/crontab /etc/crontab
COPY server_start.sh ${MAUTIC_HOME}/

EXPOSE 80 443

ENTRYPOINT [ "/var/www/html/server_start.sh" ]
# CMD ["--no-daemonize"]
