FROM liquibase/liquibase:4.8.0

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
