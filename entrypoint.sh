set -eu

filename="${MYSQL_DATABASE}-backup-`date +%Y%m%d%H%M%S`.sql.bz2"

cmd="mysqldump \
  -h${MYSQL_HOST} \
  -u${MYSQL_USER} \
  -p'${MYSQL_PASS}' \
  ${MYSQL_OPTIONS} \
  ${MYSQL_DATABASE}"

cmd="${cmd} | bzip2 -${BZIP2_LEVEL}"

case "$BACKUP_TO" in
  "s3")
    cmd="${cmd} | aws s3 cp - s3://${S3_BUCKET}/${S3_PREFIX}${filename}"
    ;;

  "gcs")
    cmd="gcloud auth activate-service-account --key-file /credentials.json && $cmd"
    cmd="${cmd} | gsutil cp - gs://${GCS_BUCKET}/${GCS_PREFIX}${filename}"
    ;;

  *)
    echo "Unknown storage '${BACKUP_TO}'" >&2
    exit 1
    ;;
esac

echo "$cmd"

bash -lc "$cmd"
