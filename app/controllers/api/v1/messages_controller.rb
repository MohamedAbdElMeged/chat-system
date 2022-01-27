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
            Publisher.publish("messages",@message)
            render "show",status: :created
        else
            render json: @message.errors , status: :unprocessable_entity
        end

    end
    def show
        render "show"
    end
    def update
        
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
        redis= RedisHelper.new()
        number = redis.get_from_redis("app_#{@application.token}_chat#{@chat.number}_message_ready_number")
        if !number
            redis.save_in_redis("app_#{@application.token}_chat#{@chat.number}_message_ready_number",1)
            number = 1
        end 
        redis.increment_counter("app_#{@application.token}_chat#{@chat.number}_message_ready_number")
        number
      end
end
