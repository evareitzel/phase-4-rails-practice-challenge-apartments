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
