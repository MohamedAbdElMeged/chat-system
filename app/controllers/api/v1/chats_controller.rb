module Api
  module V1
    class ChatsController < ApplicationController
      before_action :set_application
      before_action :set_chat, only: %i(show update destroy)

      def index
        @chats = @application.chats
        render json: ChatBlueprint.render_as_hash(@chats)
      end

      def show
        render json: ChatBlueprint.render_as_hash(@chat)
      end

      def create
        @chat = @application.chats.build
        @chat.number = new_chat_number
        if @chat.valid?
          ChatWorker.perform_async(@application.id, @application.token, @chat.number)
          render json: ChatBlueprint.render_as_hash(@chat), status: :created
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      def update
        if @chat.update(chat_params)
          render json: ChatBlueprint.render_as_hash(@chat), status: :ok
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @chat.destroy
      end

      private

      def set_chat
        @chat = Chat.find_by(number: params[:number], application_token: params[:application_token])
        render json: 'Chat Not Found' unless @chat
      end

      def new_chat_number
        redis = RedisService.new
        redis.increment_counter("app_#{@application.token}_chat_ready_number")
      end

      def chat_params
        params.require(:chat).permit
      end

      def set_application
        @application = Application.find_by(token: params[:application_token])
      end
    end
  end
end
