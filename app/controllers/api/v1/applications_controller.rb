class Api::V1::ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  def index
    @applications = Application.all

    render "index" 
  end

  # GET /applications/1
  def show
    render "show" 
  end

  # POST /applications
  def create
    @application = Application.new(application_params)

    if @application.save!
      render "show",status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render "show",status: :ok
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find_by(token: params[:token])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end
end
