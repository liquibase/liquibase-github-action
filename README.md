# 🚨 DEPRECATED - DO NOT USE

**⚠️ This action is officially deprecated and will not receive updates or security patches.**

## Use the New Official Action Instead

**Replace this deprecated action with:**
```yaml
- uses: liquibase/setup-liquibase@v1
  with:
    version: '4.32.0'  # or latest
    edition: 'oss'     # or 'pro'
- run: liquibase update --changelog-file=changelog.xml
```

## Why This Change?

- **Modern Architecture**: The new action follows GitHub Actions best practices
- **Security**: Regular updates and security patches
- **Flexibility**: Run any Liquibase command after setup
- **Performance**: Faster execution with better caching

## Migration Guide

**❌ Old (deprecated):**
```yaml
- uses: liquibase/liquibase-github-action@v7
  with:
    operation: 'update'
    changeLogFile: 'changelog.xml'
    username: ${{ secrets.DB_USER }}
    password: ${{ secrets.DB_PASS }}
    url: ${{ secrets.DB_URL }}
```

**✅ New (recommended):**
```yaml
- uses: liquibase/setup-liquibase@v1
  with:
    version: '4.32.0'
- run: |
    liquibase update \
      --changelog-file=changelog.xml \
      --username="${{ secrets.DB_USER }}" \
      --password="${{ secrets.DB_PASS }}" \
      --url="${{ secrets.DB_URL }}"
```

## Resources

- 📖 [Setup Liquibase Action Documentation](https://github.com/liquibase/setup-liquibase)
- 🚀 [Migration Examples](https://github.com/liquibase/setup-liquibase#migration-from-legacy-actions)
- 🆘 [Support](https://github.com/liquibase/setup-liquibase/issues)

---

**This repository has been archived. No further updates will be provided.**
EOF < /dev/null