class Api::V1::ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: %i[ show update destroy ]

  def index
    @chats = @application.chats
    render "index",locals: {chats: @chats},status: :ok
  end


  def show
    render "show"
  end


  def create
    @chat = @application.chats.build
    @chat.number = get_new_chat_number
    if @chat.valid?
      PublisherService.publish("chats",@chat)
      render "show", status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def update
    if @chat.update(chat_params)
      render "show", status: :ok
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @chat.destroy
  end

  private
    def set_chat
      @chat = @application.chats.find_by(number: params[:number])
    end
    def get_new_chat_number
      redis= RedisService.new()
      number = redis.get_from_redis("app_#{@application.token}_chat_ready_number")
      if !number
          redis.save_in_redis("app_#{@application.token}_chat_ready_number",1)
          number = 1
      end 
      redis.increment_counter("app_#{@application.token}_chat_ready_number")
      number
    end
    
    def chat_params
      params.require(:chat).permit()
    end
    def set_application
      @application = Application.find_by(token: params[:application_token])
    end
end
