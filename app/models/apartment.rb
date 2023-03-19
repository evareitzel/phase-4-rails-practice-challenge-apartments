class Apartment < ApplicationRecord
  has_many :leases
  has_many :tenants, through: :leases

  validates :name, presence: true
end
