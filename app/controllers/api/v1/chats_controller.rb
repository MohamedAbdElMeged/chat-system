class Api::V1::ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: %i[ show update destroy ]


  # GET /chats
  # GET /chats.json
  def index
    @chats = @application.chats
    render "index",locals: {chats: @chats},status: :ok
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    render "show"
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = @application.chats.build

    if @chat.save
      render "show", status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    if @chat.update(chat_params)
      render "show", status: :ok, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = @application.chats.find_by(number: params[:number])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit()
    end
    def set_application
      @application = Application.find_by(token: params[:application_token])
    end
end
