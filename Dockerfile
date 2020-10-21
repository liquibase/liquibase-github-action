FROM liquibase/liquibase:3.10.x

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]