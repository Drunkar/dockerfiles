FROM mysql:5.6

RUN { \
    echo '[mysqld]'; \
    echo 'character-set-server = utf8'; \
    echo 'skip-character-set-client-handshake'; \
    echo 'character-set-server = utf8'; \
    echo 'collation-server = utf8_general_ci'; \
} > /etc/mysql/conf.d/charset.cnf

#ADD charset.cnf /etc/mysql/conf.d/charset.cnf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
