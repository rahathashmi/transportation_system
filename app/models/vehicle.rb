class Vehicle < ApplicationRecord
  belongs_to :company
  has_many :trips
  
  validates :company_id, presence: true
end
