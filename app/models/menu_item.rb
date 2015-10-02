class MenuItem < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price_in_cents, presence: true, numericality: true

  has_many :order_items
  has_many :order, through: :order_items

end
