class MapIndexedMessagesHelper
    def initialize
    end
    def map_messages(messages)
        @result = []
        messages.each do |message|
            m = {
                number: message.number,
                body:  message.body
            }
            @result << m
        end
        @result
    end
end