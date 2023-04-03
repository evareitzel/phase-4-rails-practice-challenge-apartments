class ApartmentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /apartments
  def index
    apartments = Apartment.all
    render json: apartments
  end

  # GET /apartments/:id
  def show
    apartment = find_apartment
    render json: apartment
  end

  # POST /apartments
  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created    
  end

  # PATCH /apartments/:id
  def update
    apartment = find_apartment
    apartment.update!(apartment_params)
    render json: apartment, status: :accepted
  end

  # DELETE /apartments/:id
  def destroy
    apartment = find_apartment
    apartment.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json: { errors: ["Apartment not found"] }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json:{ errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def apartment_params
    params.permit(:number)
  end

  def find_apartment
    Apartment.find(params[:id])
  end

end
