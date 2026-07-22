FROM debian:12

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]