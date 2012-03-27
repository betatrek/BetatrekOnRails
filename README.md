# Betatrek web app

This is the source code for [*betatrek.com*](http://www.betatrek.com)

# Development environment setup

1. execute `bundle install; bundle --binstubs=./bundler_stubs` to install the gems and set up the bin stubs to omit `bundle exec` from the beginning of commands. [See.](http://ruby.railstutorial.org/book/ruby-on-rails-tutorial?version=3.2#sec:eliminating_bundle_exec)
2. install PostgreSQL.
3. To setup PostreSQL databases for development

	1. execute `createuser betatrek` Superuser? no, Create database? yes, Create new roles? no
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
	* Convention is to use plural nouns for controllers
* Generate new models with `rails g model **Name** optional list of attributes` (i.e. rails g model Rsvp email:string)
	* Convention is to use singular nouns for models
	* Don't forget to set attr_accessible to limit mass assignments
* Generate new test specifications with `rails g integration_test **name**` 
* List currently defined routes with `rake routes`
* When you migrate a database, use `annotate --position before` to add/update annotations in the corresponding model files
* Generate new mailers with `rails g mailer **name**`

# Deployment
1. Commit your changes to your local repository
	* Stage untracked files: `git add .` in base directory and confirm with `git status`
	* Commit all tracked (staged) files: `git commit -am "**Commit note**" (avoid exclamations, or remove the m to enter the message with the default text editor) again, check with `git status`
2. Push your local changes to the remote repository `git push`
3. Deploy to the server (with Capistrano)
	* First time (new app on the server): `cap deploy:setup` to set up the directories on the server. Then `cap cold_deploy` to deploy the app on the server
	* If you're just changing code or configuration: `cap deploy`
	* If you're just migrating a database: `cap deploy:migrate`
	* If you're changing code and migrating: `cap deploy:migration`
	* You can run commands on the server with `cap invoke COMMAND="**Command**"
	* **ssh-agent forwarding**
		** To start you're ssh-agent you can use: "exec `ssh-agent`"
		** Then to add you're default id_rsa.pub key: "ssh-add"
		** Now `ssh-add -l` should list your key's fingerprint
		** If you want to ssh with the agent: `ssh -A -i betatrek.pem …`
		** Capistrano should be configured to automatically forward your ssh-agent
4. Success!

