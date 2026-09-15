#!/bin/bash
set -euo pipefail

: "${MONGODB_URI:?MONGODB_URI is required}"
: "${AWS_ACCESS_KEY_ID:?AWS_ACCESS_KEY_ID is required}"
: "${AWS_SECRET_ACCESS_KEY:?AWS_SECRET_ACCESS_KEY is required}"
: "${S3_BUCKET:?S3_BUCKET is required}"
: "${S3_ENDPOINT_URL:?S3_ENDPOINT_URL is required}"
: "${S3_PREFIX:=pbm-backups}"

TIMESTAMP=$(date +%Y-%m-%dT%H-%M-%S)
ARCHIVE="/tmp/backup-${TIMESTAMP}.archive.gz"

echo "Running mongodump..."
mongodump --uri="${MONGODB_URI}" --archive="${ARCHIVE}" --gzip

echo "Uploading to ${S3_ENDPOINT_URL}..."
aws s3 cp "${ARCHIVE}" \
  "s3://${S3_BUCKET}/${S3_PREFIX}/${TIMESTAMP}.archive.gz" \
  --endpoint-url "${S3_ENDPOINT_URL}"

rm -f "${ARCHIVE}"
echo "Done."