FROM php:apache-stretch

# Hardening
RUN a2enmod headers \
    && sed -i "s/ServerSignature On/ServerSignature Off/" /etc/apache2/conf-available/security.conf \
    && sed -i "s/ServerTokens OS/ServerTokens Prod/" /etc/apache2/conf-available/security.conf \
    && sed -i "s/#Header set X/Header set X/" /etc/apache2/conf-available/security.conf \
    && sed -i "s/Options Indexes FollowSymLinks/Options -Indexes/" /etc/apache2/apache2.conf

# System Dependencies.
RUN apt-get update && apt-get install -y \
		libapache2-mod-auth-mellon \
		liblasso3 \
		libxmlsec1 \
		libxmlsec1-openssl \
		libxslt1.1 \
		ssmtp \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install opcache
RUN a2enmod auth_mellon

RUN echo "sendmail_path=sendmail -t" > /usr/local/etc/php/conf.d/php-sendmail.ini

RUN mkdir -p /etc/apache2/site-config \
    && mkdir -p /etc/apache2/saml

ADD config/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
ADD config/mellon.conf /etc/apache2/site-config/mellon.conf

RUN sed -i "/^<\/V/i Include site-config/mellon.conf" /etc/apache2/sites-available/000-default.conf \
    && sed -i "s/ServerAdmin webmaster/#ServerAdmin webmaster/" /etc/apache2/sites-available/000-default.conf

ADD config/mellon_create_metadata.sh /opt/mellon_create_metadata.sh
ADD config/firstrun.sh /opt/firstrun.sh
RUN chmod +x /opt/mellon_create_metadata.sh \
    && chmod +x /opt/firstrun.sh

WORKDIR /var/www/html

RUN curl -o ttrss.tar.gz https://git.tt-rss.org/fox/tt-rss/archive/19.2.tar.gz \
	&& tar --strip-components=1 -xzf ttrss.tar.gz \\
	&& rm -f ttrss.tar.gz \\
	&& rm -rf install \\
	&& rm -rf config.php-dist \\
	&& chown -R www-data:www-data

VOLUME /etc/apache2/site-config
VOLUME /etc/apache2/saml
VOLUME /etc/ssmtp
