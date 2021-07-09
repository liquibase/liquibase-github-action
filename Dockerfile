FROM liquibase/liquibase:4.4.0

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
