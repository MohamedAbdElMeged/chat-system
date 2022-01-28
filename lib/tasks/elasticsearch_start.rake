
task :elasticsearch_start => [:environment] do
    Message.__elasticsearch__.create_index!
    Message.__elasticsearch__.refresh_index!

end