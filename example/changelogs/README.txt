Explanation of Files
--------------------------------------------------------------
* samplechangelog.h2.sql defines raw SQL to update the database
** Creates two tables: person, company
** Adds a column country to table person
** Provides valid rollback for person, company and drop column country 

* configurationValues.txt lists the database URL, user and password to connect to the embedded h2 database
** These are passed to the CI/CD tool using the tool's native configuration standard
** If a different database is used, use the URL, user and password for that database

* h2tutorial.mv.db is an h2 database

####################################################
##  Get documentation at docs.liquibase.com       ##
##  Get certified courses at learn.liquibase.com  ##
##  Get support at liquibase.com/support          ##
####################################################


Copyright 2020 Datical, Inc. All rights reserved. The program is subject to the 
license agreement, copyright, trademark, patent, and other laws.
