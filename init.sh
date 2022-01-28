rm -f tmp/pids/server.pid 
bundle install
rake db:create db:migrate
rake elasticsearch_start