class Api::V1::MessagesController < ApplicationController
    before_action :set_application
    before_action :set_chat
    before_action :set_message,only: [:show,:update ,:destroy]
    def index
        @messages = @chat.messages
        render "index"
    end
    def create
        @message = @chat.messages.build(message_params)
        @message.number = get_new_message_number
        if @message.valid?
            PublisherService.publish("messages",@message)
            render "show",status: :created
        else
            render json: @message.errors , status: :unprocessable_entity
        end

    end
    def search 
        @messages= Message.partial_search(params['query'],@chat).records
        @result = MapIndexedMessagesHelper.new.map_messages(@messages)
        render json: @result 
    end
    
    def show
        render "show"
    end
    def update
        if @message.update(message_params)
            render "show", status: :ok
          else
            render json: @message.errors, status: :unprocessable_entity
          end
    end
    def destroy
        @message.destroy
    end
    private
    def set_application
        @application = Application.find_by(token: params[:application_token])
    end
    def set_chat
        @chat = @application.chats.find_by(number: params[:chat_number])
    end
    def set_message
        @message = @chat.messages.find_by(number: params[:number])
    end
    def message_params
        params.require(:message).permit(:body)
    end 
    def get_new_message_number
        redis= RedisService.new()
        redis.increment_counter("app_#{@application.token}_chat#{@chat.number}_message_ready_number")
    end
end
