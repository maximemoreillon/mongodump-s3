# mongodump-s3

A simple mongo container with the AWS CLI installed which runs `mongodump` against an entire MongoDB instance and uploads the zipped dump to an S3 bucket.

## Environment variables

Those should be straightforward

- `MONGODB_URI`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `S3_BUCKET`
- `S3_ENDPOINT_URL`
- `S3_PREFIX`
