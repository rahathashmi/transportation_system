# README
This project is designed for transportation system to manage and keep track of trips.

* Ruby version -> 2.3.0
  Installation instructions can be found in https://www.ruby-lang.org/en/documentation/installation/
* Rails Version -> 5.0.6
* Database used -> POSTGRES 9.6.1

* Configuration
  - Install Postgres 9.6.1 in your system To download: https://www.calhoun.io/how-to-install-postgresql-9-6-on-mac-os-x/
* Bundle install 
  Run bundle install for installation of gems
* Database creation
  rails db:create

* Database initialization
  Run following commands: 
  rails db:migrate (For running migrations for the system)
  rails db:seed (For populating the database)

* How to run the test suite 
Please run bin/rake for running of test cases.
If you have permission issue, run chmod u+x bin/rake for MacOS

For login: Please follow 
http://localhost:3000/oauth/token and give email, password, grant_type "password" as parameters.
