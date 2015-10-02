class Category < ActiveRecord::Base
  has_many :menu_item_categories
  has_many :menu_items, through: :menu_item_categories

  validates :name, presence: true
end
