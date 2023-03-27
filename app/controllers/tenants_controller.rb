class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /tenants
  def index
    tenants = Tenant.all
    render json: tenants, status: :ok
  end

  # GET /tenants/:id
  def show
    tenant = find_tenant
    render json: tenant, status: :ok
  end

  # POST /tenants
  def create
    tenant = Tenant.create!(tenant_params) # bang gets rescue_from exception (:not_found)
    render json: tenant, status: :created
  # make rescue_from?
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
  
  # PATCH /tenants/:id
  def update
    tenant = find_tenant
    tenant.update(tenant_params) # ! - # bang operator triggers validation in models
    # make rescue_from?
    if tenant.valid?
      render json: tenant
    else
      render json: { error: tenant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tenants/:id
  def destroy
    tenant = find_tenant
    tenant.destroy # destroy returns tenant THEN destroys
    render json: {} # head - no content is preferred
    # confirm tenant deleted
  end


  private

  def tenant_params
    params.permit(:name, :age)
  end

  def find_tenant
    Tenant.find(params[:id])
  end
  
  def render_not_found_response #(invalid)
    render json: { errors: ["Tenant not found"] }, status: :not_found # arr value!
  end
  
  # def render_unprocessable_entity_response(invalid)
  #   render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
  # end
end
