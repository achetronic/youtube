FROM debian:buster-slim



#### NGINX OPERATIONS
# Installing system packages
RUN apt-get update && apt-get install -y \ 
    nano \
    lsb-base \
    nginx-light

# Reconfiguring the server
RUN rm /etc/nginx/sites-enabled/default
COPY docker-files/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Building canonical public folder
RUN rm -rf /var/www/html
RUN mkdir -p /var/www/public



#### FINAL OPERATIONS
COPY docker-files/init.sh /init.sh
RUN chown root:root /init.sh
RUN chmod +x /init.sh
EXPOSE 80 443
CMD /init.sh
