# README

A rails api to upload and view S3 assets via the S3 signed URL.

## Local Installation

`git clone` the repository and `cd` into it

run `bundle`

setup the database:

create the postgres user:

    $ sudo -u postgres psql

    postgres=# create user rails with password 'rails';
    postgres=# alter role rails  superuser createrole createdb replication;

    <CTRL+D to exit psql cli>

create the database and set the schema:

    $ rails db:setup


Create a file `config/s3_credentials.yml` with S3 credentials. Make sure the bucket is created
and user has access. It should look something like:

    default: &default
      aws_access_key_id: ..
      aws_secret_access_key: ..
      bucket_name: ..
      region: ..

    development:
      <<: *default

    test:
      <<: *default

    production:
      <<: *default


run the server:

    $ rails server

run the tests:

    $ rails test



## Usage

upload an asset:

    POST /asset

Retruns a `upload_url` and `id`. Use `upload_url` to upload your file. Valid for 60 seconds by default.

confirm asset was uploaded:

    PUT ​/asset/​<asset-id>
    Body:
    {
        ​"status"​: ​"uploaded"
    }


get a download_url for an existing asset:

    GET /asset/<asset-​id​>?timeout=​100

## Notes

- Change the defaults by editing `config/s3_url.rb`

- The `AssetUrlCreator` is mocked in tests

- Both requests (`POST /asset` and `GET /asset/<asset-​id​>`) will succeed even if the S3 user
(as defined in `s3_credentials.yml`) is forbidden to access the bucket. An error will be thrown only
when you try to upload the file to the `upload_url`.

- A S3 signed URL once created cannot be revoked


## TODO

- update `status` of `asset` from `active` in a background job with a timeout,
i.e. do away with `PUT ​/asset/​<asset-id>`

- Handle upload failures

- Take a file name with extension in `POST /asset` request so that the downloaded file has a nice name,
or atleast the correct extension
