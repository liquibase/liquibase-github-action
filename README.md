# Deprecated

This repository is being replaced with [Liquibase Github Actions](https://github.com/liquibase-github-actions) which includes full command and parameter coverage. This repository will not receive any future updates. Please update your workflows. Any issues should be reported to the [Liquibase GitHub Action Generator](https://github.com/liquibase/github-action-generator/issues) repository.

### Usage

Basic Update

```yaml
steps:
  - uses: actions/checkout@v2
  - uses: liquibase/liquibase-github-action@v7
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
  - uses: liquibase/liquibase-github-action@v7
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

`operation` is required for every use.

The `operation` input expects one of the following:

- update
- updateCount
- tag
- updateToTag
- updateTestingRollback
- rollback
- rollbackCount
- rollbackToDate
- updateSQL
- futureRollbackSQL
- status
- history
- diff
- validate
- 'checks run' (note that the `checks run` command must be wrapped with quotes in your `build.yml` because the command has a space in it)

### Optional Inputs

`username`, `password`, `url`, `classpath`, `changeLogFile`, `count`, `tag`, `date`, `referenceUrl`, `proLicenseKey` (deprecated in favor of `licenseKey`) and `hubApiKey` are optional inputs that may be required by some operations.

It is recommended that `licenseKey` and `hubApiKey` are not stored in plaintext, but rather using a [GitHub secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets):

```yaml
          licenseKey: ${{ secrets.PRO_LICENSE_KEY }}
```

The following operations have the subsequent required inputs:

#### updateCount

- username
- password
- url
- classpath
- changeLogFile
- count
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### tag

- username
- password
- url
- tag
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### updateToTag

- username
- password
- url
- classpath
- changeLogFile
- tag
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### update-testing-rollback

- username
- password
- url
- classpath
- changeLogFile

#### rollback

- username
- password
- url
- classpath
- changeLogFile
- tag
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### rollbackCount

- username
- password
- url
- classpath
- changeLogFile
- count
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### rollbackToDate

- username
- password
- url
- classpath
- changeLogFile
- date
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### updateSQL

- username
- password
- url
- changeLogFile
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### futureRollbackSQL

- username
- password
- url
- classpath
- changeLogFile
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### status

- username
- password
- url
- classpath
- changeLogFile
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### diff

- username
- password
- url
- referenceUrl
- databaseChangeLogTableName (optional)
- databaseChangeLogLockTableName (optional)

#### validate

- username
- password
- url
- changeLogFile

#### checks run

- changeLogFile
- checksSettingsFile

### Secrets

It is a good practice to protect your database credentials with [Github Secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets)

### Want to help?

Want to file a bug, contribute some code, or improve documentation? Excellent! Read up on our
guidelines for [contributing](https://www.liquibase.org/community/index.html)!

#### Developer instructions

We've found that the easiest way to test changes to this GitHub action is to:

- fork this repo to your personal account
- create a sample `build.yml` to trigger the action, noting that the `uses` line specifies the relative path, which will run the action as specified in your fork (rather than the action that is published by Liquibase)

    ```yaml
    name: Build and Test
    
    on: [push, pull_request]
    
    jobs:
      runchecks:
        name: "Run Liquibase Quality Checks"
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - uses: ./
            with:
              operation: 'checks run'
              changeLogFile: 'mychangelog.sql'
              checksSettingsFile: 'liquibasech.conf'
              proLicenseKey: ${{ secrets.PRO_LICENSE_KEY }}
    ```

- make changes as desired and observe the execution in GitHub
