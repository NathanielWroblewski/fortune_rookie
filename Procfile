web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec rake jobs:work
web: bundle exec rake db:migrate
web: bundle exec rake db:seed
