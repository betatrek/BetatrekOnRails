# Betatrek web app

This is the source code for [*betatrek.com*](http://www.betatrek.com)

# Development environment setup

1. execute `bundle install; bundle --binstubs=./bundler_stubs` to install the gems and set up the bin stubs to omit `bundle exec` from the beginning of commands. [See.](http://ruby.railstutorial.org/book/ruby-on-rails-tutorial?version=3.2#sec:eliminating_bundle_exec)
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

# Development notes

* Can use `rails g` instead of `rails generate`
* Can user `rails s` instead of `rails s`
* Sometimes it is required to restart the server or guard processes when modifying certain files
* Generate new controllers with `rails g controller **Name** optional list of actions --no-test-framework` (i.e. rails g controller StaticPages home --no-test-framework)
* Generate new test specifications with `rails g integration_test **name**` 
* List currently defined routes with `rake routes`