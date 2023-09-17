FROM alpine

RUN apk add lighttpd
ADD index.html /var/www/localhost/htdocs

ADD guest_init.sh /bin/

CMD /bin/guest_init.sh
#ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
