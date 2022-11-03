rm -f tmp/pids/server.pid
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake elasticsearch_start