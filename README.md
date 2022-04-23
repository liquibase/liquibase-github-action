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
- 'checks run' (note that the `checks run` command must be wrapped with quotes in your `build.yml` because the command has a space in it)

### Optional Inputs

`username`, `password`, `url`, `classpath`, `changeLogFile`, `count`, `tag`, `date`, `referenceUrl`, `proLicenseKey` and `hubApiKey` are optional inputs that may be required by some operations.

It is recommended that `proLicenseKey` and `hubApiKey` are not stored in plaintext, but rather using a [GitHub secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets):

```
          proLicenseKey: ${{ secrets.PRO_LICENSE_KEY }}
```

The following operations have the subsequent required inputs:

#### updateCount

- username
- password
- url
- classpath
- changeLogFile
- count

#### tag

- username
- password
- url
- tag

#### updateToTag

- username
- password
- url
- classpath
- changeLogFile
- tag

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

#### rollbackCount

- username
- password
- url
- classpath
- changeLogFile
- count

#### rollbackToDate

- username
- password
- url
- classpath
- changeLogFile
- date

#### updateSQL

- username
- password
- url
- changeLogFile

#### futureRollbackSQL

- username
- password
- url
- classpath
- changeLogFile

#### status

- username
- password
- url
- classpath
- changeLogFile

#### diff

- username
- password
- url
- referenceUrl

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
    ```
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