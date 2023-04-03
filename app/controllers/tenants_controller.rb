class TenantsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /apartments
  def index
    tenants = Tenant.all
    render json: tenants
  end

  # GET /tenants/:id
  def show
    tenant = find_tenant
    render json: tenant
  end

  # POST /tenants
  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created    
  end

  # PATCH /tenants/:id
  def update
    tenant = find_tenant
    tenant.update!(tenant_params)
    render json: tenant, status: :accepted
  end

  # DELETE /tenants/:id
  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json: { errors: ["Tenant not found"] }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json:{ errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def tenant_params
    params.permit(:name, :age)
  end

  def find_tenant
    Tenant.find(params[:id])
  end

end
