# All Good Things Backend

Backend database for [`All Good Things`](https://github.com/jessemcready/all-good-things). 

## Technologies
 - Ruby on Rails for the backend language. Created this API by using `rails new` with the `--api` flag. The database is Postgres for easier push to Heroku at a later date.
 - BCrypt to have secure passwords in the backend for users that sign up.
 - Active Model Serializers to render model associations and format the associations before they're sent down.
 
## How to use
After cloning down, make sure you have Postgres running in the background. Then run `rails db:create && rails db:migrate`. This will create the database in your Postgres server and then run the migrations.  If you want some test data, you can run `rails db:seed`.  After you're finished with migrating, you can run `rails s` which will open an endpoint for you to fetch from at `localhost:3000/api/v1/` + a path to a specifc resource.  If you're curious as to what routes you can hit, you can run `rails routes`
