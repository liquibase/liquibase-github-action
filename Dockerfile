FROM liquibase/liquibase:4.1

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
