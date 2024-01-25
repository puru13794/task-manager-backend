

## Deployment


Deployed in Render: <https://task-manager-backend-s40k.onrender.com>
Get Postman collection for testing api's : <https://web.postman.co/workspace/My-Workspace~a65b135e-32a1-44ec-8ab3-e4b517e79588/overview>

## Local Setup 

Clone the Repo `git clone git@github.com:puru13794/task-manager-backend.git`
install Postgres in already not installed:

* change `username` and `password` in `config/database.yml` file to system_name and system passwords for less headache, or create a new user passwords and grant privilages more here: <https://www.digitalocean.com/community/tutorials/how-to-set-up-ruby-on-rails-with-postgres>

* run `rails db:create`

* run `rails db:migrate` and `rails s` should be done with localsetup


