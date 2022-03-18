FROM liquibase/liquibase:4.9.0

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
