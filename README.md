# liquibase-github-action

Official Github Action to run Liquibase in your pipeline.

### Usage

Basic Update

```yaml
steps:
  - uses: actions/checkout@v2
  - uses: liquibase/liquibase-github-action@v4
    with:
      operation: 'update'
      classpath: 'example/changelogs'
      changeLogFile: 'samplechangelog.h2.sql'
      username: ${{ secrets.USERNAME }}
      password: ${{ secrets.PASSWORD }}
      url: ${{ secrets.URL }}
```

Optional Parameter Example:

```yaml
steps:
  - uses: actions/checkout@v2
  - uses: liquibase/liquibase-github-action@v4
    with:
      operation: 'updateCount'
      classpath: 'example/changelogs'
      changeLogFile: 'samplechangelog.h2.sql'
      username: ${{ secrets.USERNAME }}
      password: ${{ secrets.PASSWORD }}
      url: ${{ secrets.URL }}
      count: 2
```

### Required Inputs

`operation`, `username`, `password`, and `url` are required for every use.

The `operation` input expects one of the following:

- update
- updateCount
- tag
- updateToTag
- rollback
- rollbackCount
- rollbackToDate
- updateSQL
- futureRollbackSQL
- status
- history
- diff

### Optional Inputs

`classpath`, `changeLogFile`, `count`, `tag`, `date`, and `referenceUrl` are optional inputs that may be required by some operations. The following operations have the subsequent required inputs:

#### updateCount

- classpath
- changeLogFile
- count

#### tag

- tag

#### updateToTag

- classpath
- changeLogFile
- tag

#### rollback

- classpath
- changeLogFile
- tag

#### rollbackCount

- classpath
- changeLogFile
- count

#### rollbackToDate

- classpath
- changeLogFile
- date

#### updateSQL

- changeLogFile

#### futureRollbackSQL

- classpath
- changeLogFile

#### status

- classpath
- changeLogFile

#### diff

- referenceUrl

### Secrets

It is a good practice to protect your database credentials with [Github Secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets)

### Want to help?

Want to file a bug, contribute some code, or improve documentation? Excellent! Read up on our
guidelines for [contributing](https://www.liquibase.org/community/index.html)!
