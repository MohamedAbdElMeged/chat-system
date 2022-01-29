class Api::V1::ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  def index
    @applications = Application.all

    render "index" 
  end


  def show
    render "show" 
  end


  def create
    @application = ApplicationService::CreateApplication.new(params[:name]).call
    if @application.save!
      render "show",status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end


  def update
    if @application.update(application_params)
      render "show",status: :ok
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @application.destroy
  end

  private
    def set_application
      @application = Application.find_by(token: params[:token])
    end

    def application_params
      params.require(:application).permit(:name)
    end
end
