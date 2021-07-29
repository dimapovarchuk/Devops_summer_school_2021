FROM alpine:latest
RUN apk add apache2 --update-cache
COPY index.html /var/www/localhost/htdocs/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
