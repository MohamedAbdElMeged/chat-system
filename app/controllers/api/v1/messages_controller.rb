module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_chat
      before_action :set_message, only: %i(show update destroy)
      def index
        @messages = @chat.messages
        render json: MessageBlueprint.render_as_hash(@messages), status: :ok
      end

      def create
        @message = @chat.messages.build(message_params)
        @message.number = new_message_number
        if @message.valid?
          MessageWorker.perform_async(@chat.application_token, @chat.id, @chat.number, @message.number, @message.body)
          render json: MessageBlueprint.render_as_hash(@message), status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      def search
        @messages = Message.partial_search(params['query'], @chat).results.to_a
        render json: MessageBlueprint.render_as_hash(@messages)
      end

      def show
        render json: MessageBlueprint.render_as_hash(@message), status: :ok
      end

      def update
        if @message.update(message_params)
          render json: MessageBlueprint.render_as_hash(@message), status: :ok
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @message.destroy
      end

      private

      def set_chat
        @chat = Chat.find_by(number: params[:chat_number], application_token: params[:application_token])
        render json: 'Chat Not Found' unless @chat
      end

      def set_message
        @message = @chat.messages.find_by(number: params[:number])
        render json: 'Message Not Found' unless @message
      end

      def message_params
        params.require(:message).permit(:body)
      end

      def new_message_number
        redis = RedisService.new
        redis.increment_counter("app_#{params[:application_token]}_chat#{@chat.number}_message_ready_number")
      end
    end
  end
end
