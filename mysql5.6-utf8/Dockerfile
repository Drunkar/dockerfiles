FROM mysql:5.6

RUN { \
    echo '[client]'; \
    echo 'default-character-set = utf8mb4'; \
    echo '[mysqld]'; \
    echo 'character-set-server = utf8mb4'; \
    echo 'skip-character-set-client-handshake'; \
} > /etc/mysql/my.cnf

#ADD charset.cnf /etc/mysql/conf.d/charset.cnf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
