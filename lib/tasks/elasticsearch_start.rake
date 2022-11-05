task elasticsearch_start: [:environment] do
  Message.import force: true unless Message.all.empty?
end
