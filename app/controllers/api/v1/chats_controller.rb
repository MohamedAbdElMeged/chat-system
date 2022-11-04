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
      @chat = Chat.find_by(number: params[:number],application_token: params[:application_token])
      render json: "Chat Not Found" unless @chat
    end
    def get_new_chat_number
      redis= RedisService.new()
      redis.increment_counter("app_#{@application.token}_chat_ready_number")
    end
    
    def chat_params
      params.require(:chat).permit()
    end
    def set_application
      @application = Application.find_by(token: params[:application_token])
    end
end
