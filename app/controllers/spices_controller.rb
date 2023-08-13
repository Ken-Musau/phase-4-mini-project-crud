class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #   GET /spice
  def index
    render json: Spice.all, status: :ok
  end

  #   POST /spices
  def create
    render json: Spice.create(spice_params), status: :created
  end

  #   def show
  #     spice = find_spice
  #     render json: spice
  #   end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice, status: :ok
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  end

  private

  def find_spice
    Spice.find(params[:id])
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_not_found_response
    render json: { error: "Spice not found" }, status: :not_found
  end
end
