# README


## Local Installation

`git clone` the repository

run `bundle` inside the dir

setup the database:

create the postgres user:

    $ sudo -u postgres psql

    postgres=# create user rails with password 'rails';
    postgres=# alter role rails  superuser createrole createdb replication;

    <CTRL+D to exit psql cli>

create the database and set the schema:

    $ rails db:setup

run the server:

    $ rails server

run the tests:

    $ rails test

## TODO:

 - update `status` of `asset` from `active` in a background job with a timeout,
 i.e. do away with `PUT ​/asset/​<asset-id>`

 - Handle upload failures
