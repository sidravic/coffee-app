class Customer < ActiveRecord::Base
  has_one :order

  validates :name, presence: true
end
