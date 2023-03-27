class LeasesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # GET /leases
    def index
        leases = Lease.all
        render json: leases, status: :ok
    end

    # POST /leases
    def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
    end
    
    # DELETE /leases/:id
    def destroy
        lease = Lease.find(params[:id])
        lease.destroy        
        head :no_content # preferred to render json: {}
    end
  
  
    private
  
    def lease_params
      params.permit(:rent, :apartment_id, :tenant_id)
    end
    
    def render_not_found_response
        render json: { errors: ["Lease not found"] }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
    end

end
