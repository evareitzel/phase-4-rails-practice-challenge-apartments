04/05/2023 | 11AM - 12:20PM (80min)

# Generate resources
  $ rails g resource Lease rent:integer apartment:belongs_to tenant:belongs_to --no-test-framework
  $ rails g resource Apartment number:integer --no-test-framework
  $ rails g resource Tenant name age:integer --no-test-framework

# add has_many model associations
# define model validations so that no bad data can be saved to the database 
  # validates
  # inclusion: 18..110

$ rails db:migrate db:seed
$ rails s

# Add serializers

  # add AMS(ActiveModel::Serializer) gem to Gemfile
    gem 'active_model_serializers'
    $ bundle install

  $ rails g serializer apartment
  $ rails g serializer lease
  $ rails g serializer tenant

  # specify serrializer attributes

# define routes
# add controller actions

# resources :leases, only: [:index, :create, :destroy]



## Draft 1

# # 8:40PM

# ## PSEUDOCODE
# # $ rails g model Apartment number:integer
# # $ rails g model Tenant name:string age:integer
#   # validates :name, present: true
#   # validates :age, numericality: {minimum: 18}
# # $ rails g model Lease rent:integer

# # CRUD Apartments
# # CRUD Tenants
# # CD Lease

# # handle errors & invalid data
#   # status code
#   # error msg


# ## Terminal commands
# # Models
# $ rails g model Apartment number:integer --no-test-framework
# $ rails g model Tenant name:string age:integer --no-test-framework
# $ rails g model Lease rent:integer --no-test-framework

# $ rails db:migrate
# # add routes
# $ rails routes # verify routes 

# # Controllers
# $ rails g controller Apartments --no-test-framework
# $ rails g controller Tenants --no-test-framework
# $ rails g controller Leases --no-test-framework

# # add associations to models
# # add validations to models
# $ rails db:migrate db:seed

# # add CRUD actions to controllers


# ####

# # POST /apartments

# # 1 - not wkg
# def create
#   apartment = Apartment.create(apartment_params)
#   if apartment.valid?
#     render json: apartment, status: :created
#   else
#     render json: { errors: apartment.errors }, status: :unprocessable_entity
#   end
# end

# # 2 - not wkg
# def create
#   apartment = Apartment.create!(apartment_params)
#   render json: apartment, status: :created
# rescue ActiveRecord::RecordInvalid => invalid
#   render json: { errors: invalid.record.errors }, status: :unprocessable_entity
# end

#   # not wkg - error msg not correct
#   # PATCH /apartments/:id
#   def update
#     apartment = find_apartment
#     apartment.update(apartment_params)
#     if apartment.valid?
#       render json: apartment, status: :accepted
#     else
#       render json: { error: apartment.errors.full_messages }, status: :unprocessable_entity
#     end
#   end


#   ## tenants_controller - pre-refactor
#   class TenantsController < ApplicationController
#     rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
#       # GET /tenants
#       def index
#         tenants = Tenant.all
#         render json: tenants, status: :ok
#       end
    
#       # GET /tenants/:id
#       def show
#         tenant = Tenant.find_by(id: params[:id])
#         # not_found handled by rescue_from :render_not_found_response
#         if tenant
#           render json: tenant, status: :ok
#         else
#           render json: { error: "Tenant not found" }, status: :not_found
#         end
#       end
    
#       # POST /tenants
#       def create
#         tenant = Tenant.create!(tenant_params)
#         render json: tenant, status: :created
#       rescue ActiveRecord::RecordInvalid => e
#         render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
#       end
      
#       # PATCH /tenants/:id
#       def update
#         tenant = Tenant.find(params[:id])
#         tenant.update(tenant_params)
#         if tenant.valid?
#           render json: tenant
#         else
#           render json: { error: tenant.errors.full_messages }, status: :unprocessable_entity
#         end
#       end
    
#       # DELETE /tenants/:id
#       def destroy
#         tenant = Tenant.find(params[:id])
#         tenant.destroy
#         render json: {}
#       end
    
    
#       private
    
#       def tenant_params
#         params.permit(:name, :age)
#       end
    
#       def render_not_found_response
#         render json: { error: "Tenant not found" }, status: :not_found
#       end
      
#     end

    
#     ## tenants_controller - pre-refactor, post-Tech Coach discussion

#     class TenantsController < ApplicationController
#       rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
#       # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
#       # GET /tenants
#       def index
#         tenants = Tenant.all
#         render json: tenants, status: :ok
#       end
    
#       # GET /tenants/:id
#       def show
#         tenant = find_tenant
#         render json: tenant, status: :ok
#       end
    
#       # POST /tenants
#       def create
#         tenant = Tenant.create!(tenant_params) # bang gets rescue_from exception (:not_found)
#         render json: tenant, status: :created
#       rescue ActiveRecord::RecordInvalid => e
#         render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
#       end
      
#       # PATCH /tenants/:id
#       def update
#         tenant = find_tenant
#         tenant.update(tenant_params) # ! - # bang operator triggers validation in models
#         if tenant.valid?
#           render json: tenant
#         else
#           render json: { error: tenant.errors.full_messages }, status: :unprocessable_entity
#         end
#       end
    
#       # DELETE /tenants/:id
#       def destroy
#         tenant = find_tenant
#         tenant.destroy # destroy returns tenant THEN destroys
#         render json: {} # head - no content is preferred
#         # confirm tenant deleted
#       end
    
    
#       private
    
#       def tenant_params
#         params.permit(:name, :age)
#       end
    
#       def find_tenant
#         Tenant.find(params[:id])
#       end
      
#       def render_not_found_response#(invalid)
#         render json: { errors: ["Tenant not found"] }, status: :not_found # arr value!
#       end
      
#       # def render_unprocessable_entity_response(invalid)
#       #   render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
#       # end
#     end
    