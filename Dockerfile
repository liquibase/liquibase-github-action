FROM liquibase/liquibase:4.2.2

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
