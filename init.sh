rm -f tmp/pids/server.pid
bundle install
rake db:create
rake db:migrate
rake elasticsearch_start