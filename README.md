# Betatrek web app

This is the source code for [*betatrek.com*](http://www.betatrek.com)

# Development environment setup

* execute `bundle install; bundle --binstubs=./bundler_stubs` to install the gems and set up the bin stubs to omit `rake exec` from the beginning of commands.
* install PostgreSQL.
* To setup PostreSQL databases for development
** execute `createuser betatrek` superuser? no create database? no create new roles? no
** execute `psql postgres` to enter the PostgreSQL terminal
** enter `ALTER USER betatrek WITH ENCRYPTED PASSWORD 'bettafishswimminginapool';` to add a password.
** confirm with `SELECT * FROM pg_user`
** execute `createdb -O betatrek betatrek_test`
** execute `createdb -O betatrek betatrek_development`
** execute `createdb -O betatrek betatrek_production`
** Notes:
*** confirm their existence with `psql betatrek_<environment>` (i.e. `psql betatrek_test`)
*** in psql terminal tab for SQL autocompletes. "\q" to quit
** in the BetatrekOnRails directory execute `rake db:migrate` (set up schemas), `rake db:populate` (fill the databases with sample data) and `rake db:test:prepare` (to prepare the test database for the test environment)
* open a new terminal to start the guard process. Execute `guard`
* open another terminal to start the server process. Execute `rails server`
