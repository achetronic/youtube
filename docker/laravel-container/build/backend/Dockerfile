FROM debian:buster-slim



#### DEFINING VARS
ARG php_version=7.3
ARG php_fpm_path="/etc/php/${php_version}/fpm/"
ARG php_fpm_pool_path="/etc/php/${php_version}/fpm/pool.d/"



#### LARAVEL OPERATIONS
RUN apt-get update

# Installing system packages
RUN apt-get install -y -qq --force-yes \
	at \
    lsb-base \
	procps \
	cron \
    php${php_version}-fpm \
        --no-install-recommends > /dev/null

# Installing packages for Laravel
RUN apt-get install -y -qq --force-yes \
    php${php_version}-bcmath \
    php${php_version}-json \
    php${php_version}-mbstring \
    php${php_version}-tokenizer \
    php${php_version}-xml \
    php${php_version}-mysql \
    php-redis \
	php-curl \
	--no-install-recommends > /dev/null
	
# Installing temporary packages
RUN apt-get install -y -qq --force-yes \
	composer \ 
	git \ 
	zip \ 
	unzip \ 
	php${php_version}-zip \
	--no-install-recommends > /dev/null



#### CONFIGURING PHP-FPM
# CONFIGURING POOL
COPY .build/www.conf ${php_fpm_pool_path}/www.conf
RUN chown root:root ${php_fpm_pool_path}/www.conf
RUN chmod 644 ${php_fpm_pool_path}/www.conf

# CONFIGURING BASE
COPY .build/php.ini ${php_fpm_path}/php.ini
RUN chown root:root ${php_fpm_path}/php.ini
RUN chmod 644 ${php_fpm_path}/php.ini



####
# Creating a temporary folder for our app
RUN mkdir -p /tmp/laravel

# Download the entire project
COPY . /tmp/laravel/

# Create needed folders for composer autoloader optimization
RUN mkdir -p /app/database
RUN mkdir -p /app/database/seeds
RUN mkdir -p /app/database/factories

# Defining which packages Composer will install
RUN cp /tmp/laravel/composer.lock /app/composer.lock
RUN cp /tmp/laravel/composer.json /app/composer.json

# Please, Composer, install them
RUN composer install -d /app --no-dev --no-scripts

# Moving Laravel to the right place
RUN cp -r /tmp/laravel/* /app
RUN rm -rf /tmp/laravel
RUN touch /app/.env

# Setting the configurations values for Laravel
RUN cd /app && composer dump-autoload

# Deleting system temporary packages
RUN apt-get purge -y -qq --force-yes \
	composer \ 
	git \ 
	zip \ 
	unzip \ 
	php${php_version}-zip \
	> /dev/null

# Cleaning the system
RUN apt-get -y -qq --force-yes autoremove > /dev/null

# Changing permissions of the entire Laravel
#RUN chown root:root -R /app
RUN chown www-data:www-data -R /app
RUN find /app -type f -exec chmod 644 {} \;
RUN find /app -type d -exec chmod 755 {} \;

# Crafting the entrypoint script
RUN rm -rf /entrypoint.sh && touch /entrypoint.sh
RUN echo "#!/bin/bash" >> /entrypoint.sh
RUN echo "service cron start" >> /entrypoint.sh
RUN echo "service atd start" >> /entrypoint.sh
RUN echo "service php${php_version}-fpm start" >> /entrypoint.sh
RUN echo "shopt -s dotglob" >> /entrypoint.sh
RUN echo "mkdir -p /var/www/" >> /entrypoint.sh
RUN echo "mv /app/* /var/www/" >> /entrypoint.sh
RUN echo "(crontab -l; echo '* * * * * cd /var/www && php artisan schedule:run >> /dev/null 2>&1';) | crontab -" >> /entrypoint.sh
RUN echo "touch /etc/crontab /etc/cron.*/*" >> /entrypoint.sh
RUN echo 'exec "$@"' >> /entrypoint.sh
RUN echo "php /var/www/artisan config:cache" >> /entrypoint.sh
RUN echo "php /var/www/artisan migrate" >> /entrypoint.sh
RUN echo "php /var/www/artisan db:seed --force" >> /entrypoint.sh
#RUN echo "sh /app/runtime/takeover.sh" >> /entrypoint.sh
RUN echo "/bin/bash" >> /entrypoint.sh

# Giving permissions to the entrypoint script
RUN chown root:root /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Giving permissions to the livenessprobe script
# RUN chown root:root /app/runtime/livenessprobe.sh
# RUN chmod +x /app/runtime/livenessprobe.sh

# Giving permissions to the takeover script
# RUN chown root:root /app/runtime/takeover.sh
# RUN chmod +x /app/runtime/takeover.sh

# Gaining a bit of comfort
WORKDIR "/var/www"

# Executing the scripts
ENTRYPOINT ["/entrypoint.sh"]