FROM liquibase/liquibase:4.1.x

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
