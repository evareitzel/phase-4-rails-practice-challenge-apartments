class ApartmentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /apartments
  def index
    apartments = Apartment.all
    render json: apartments
  end

  # GET /apartments/:id
  def show
    apartment = find_apartment
      render json: apartment, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  # POST /apartments
  def create
    apartment = Apartment.create(apartment_params)
    if apartment.valid?
      render json: apartment, status: :created
    else
      render json: { errors: apartment.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # PATCH /apartments/:id
  def update
    apartment = find_apartment
    apartment.update(apartment_params)
    if apartment.valid?
      render json: apartment, status: :accepted
    else
      render json: { error: apartment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /apartments/:id
  def destroy
    apartment = find_apartment
    apartment.destroy!
    head :no_content
  end


  private

  def apartment_params
    params.permit(:number)
  end

  def find_apartment
    Apartment.find(params[:id])
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

end
