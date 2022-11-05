task elasticsearch_start: [:environment] do
  unless Message.all.empty?
    Message.__elasticsearch__.create_index!
    Message.__elasticsearch__.refresh_index!
  end
end
