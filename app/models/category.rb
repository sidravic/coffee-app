class Category < ActiveRecord::Base
  SIZES = ['tall', 'grande', 'venti']

  has_many :menu_item_categories
  has_many :menu_items, through: :menu_item_categories

  validates :name, presence: true

  scope :sizes, Proc.new { where('categories.name IN (?)', SIZES)}
end
