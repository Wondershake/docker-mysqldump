Docker Image: mysqldump and backup
===================================

# Usage
See also `docker-compose.yml` as an example.

## Backup to Amazon S3

With access key:

```bash
docker run \
  -e "MYSQL_DATABASE=mydatabase" \
  -e "BACKUP_TO=s3" \
  -e "AWS_ACCESS_KEY_ID=xxxx" \
  -e "AWS_SECRET_ACCESS_KEY=xxxx" \
  wondershake/mysqldump
```

With IAM role:

```bash
docker run \
  -e "MYSQL_DATABASE=mydatabase" \
  -e "BACKUP_TO=s3"
  wondershake/mysqldump
```

## Backup to Google Cloud Storage

```bash
docker run \
  -e "MYSQL_DATABASE=mydatabase" \
  -e "BACKUP_TO=gcs" \
  -v "/path/to/service-account-key.json:/credentials.json" \
  wondershake/mysqldump
```

# Environment Variables
| Variable | Example | Default |
| -------- | ------- | ------- |
| `MYSQL_HOST` | `mysql-host.example.com` | `127.0.0.1` |
| `MYSQL_PORT` | `3306` | `3306` |
| `MYSQL_USER` | `root` | `root` |
| `MYSQL_PASS` | `password` | |
| `MYSQL_DATABASE` | `mydatabase` | |
| `BACKUP_TO` | `gcs` | `s3` |
| `AWS_ACCESS_KEY_ID` | `xxx` | |
| `AWS_SECRET_ACCESS_KEY` | `xxx` | |
| `S3_BUCKET` | `mybucket` | |
| `S3_PREFIX` | `backups/` | |
| `GCS_BUCKET` | `mybucket` | |
| `GCS_PREFIX` | `backups/` | |
