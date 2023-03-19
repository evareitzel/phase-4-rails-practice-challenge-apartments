# 8:40PM

## PSEUDOCODE
# $ rails g model Apartment number:integer
# $ rails g model Tenant name:string age:integer
  # validates :name, present: true
  # validates :age, numericality: {minimum: 18}
# $ rails g model Lease rent:integer

# CRUD Apartments
# CRUD Tenants
# CD Lease

# handle errors & invalid data
  # status code
  # error msg


## Terminal commands
# Models
$ rails g model Apartment number:integer --no-test-framework
$ rails g model Tenant name:string age:integer --no-test-framework
$ rails g model Lease rent:integer --no-test-framework

$ rails db:migrate
# add routes
$ rails routes # verify routes 

# Controllers
$ rails g controller Apartments --no-test-framework
$ rails g controller Tenants --no-test-framework
$ rails g controller Leases --no-test-framework

# add associations to models
# add validations to models
$ rails db:migrate db:seed

# add CRUD actions to controllers


####

# POST /apartments

# 1 - not wkg
def create
  apartment = Apartment.create(apartment_params)
  if apartment.valid?
    render json: apartment, status: :created
  else
    render json: { errors: apartment.errors }, status: :unprocessable_entity
  end
end

# 2 - not wkg
def create
  apartment = Apartment.create!(apartment_params)
  render json: apartment, status: :created
rescue ActiveRecord::RecordInvalid => invalid
  render json: { errors: invalid.record.errors }, status: :unprocessable_entity
end

  # not wkg - error msg not correct
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
