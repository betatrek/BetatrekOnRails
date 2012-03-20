# Betatrek web app

This is the source code for [*betatrek.com*](http://www.betatrek.com)

# Development environment setup

1. execute `bundle install; bundle --binstubs=./bundler_stubs` to install the gems and set up the bin stubs to omit `rake exec` from the beginning of commands.
2. install PostgreSQL.
3. To setup PostreSQL databases for development

	1. execute `createuser betatrek` superuser? no create database? no create new roles? no
	2. execute `psql postgres` to enter the PostgreSQL terminal
	3. enter `ALTER USER betatrek WITH ENCRYPTED PASSWORD 'bettafishswimminginapool';` to add a password.
	4. confirm with `SELECT * FROM pg_user`
	5. execute `createdb -O betatrek betatrek_test`
	6. execute `createdb -O betatrek betatrek_development`
	7. execute `createdb -O betatrek betatrek_production`
		* Notes:
			- confirm their existence with `psql betatrek_<environment>` (i.e. `psql betatrek_test`)
			- in psql terminal tab for SQL autocompletes. "\q" to quit
	8. in the BetatrekOnRails directory execute `rake db:migrate` (set up schemas), `rake db:populate` (fill the databases with sample data) and `rake db:test:prepare` (to prepare the test database for the test environment)
4. open a new terminal to start the guard process. Execute `guard`
5. open another terminal to start the server process. Execute `rails server`
