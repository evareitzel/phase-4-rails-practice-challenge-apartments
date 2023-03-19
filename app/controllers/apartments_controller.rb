class ApartmentsController < ApplicationController

  # GET /apartments
  def index
    apartments = Apartment.all
    render json: apartments
  end

  # GET /apartments/:id
  def show
    apartment = find_apartment
    if apartment
      render json: apartment
    else
      render json: { error: "Apartment not found" }, status: :not_found
    end
  end

  # POST /apartments
  def create
    apartment = Apartment.create(apartment_params)
    if apartment.valid?
      render json: apartment, status: :created
    else
      render json: apartment.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH /apartments/:id
  # def update
  # end

  # DELETE /apartments/:id
  # def destroy
  # end


  private

  def apartment_params
    params.permit(:number)
  end

  def find_apartment
    Apartment.find_by(id: params[:id])
  end

end
