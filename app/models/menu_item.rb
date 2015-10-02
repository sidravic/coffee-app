class MenuItem < ActiveRecord::Base
  validates :name, presence: true
  validates :price_in_cents, presence: true, numericality: true

  has_many :order_items
  has_many :order, through: :order_items

  has_many :menu_item_categories
  has_many :categories, through: :menu_item_categories

  has_one :sales_aggregate

  after_create :generate_aggregate_record

  def generate_aggregate_record
    create_sales_aggregate
  end

end
