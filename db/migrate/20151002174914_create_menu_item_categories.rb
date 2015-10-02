class CreateMenuItemCategories < ActiveRecord::Migration
  def change
    create_table :menu_item_categories, id: :uuid do |t|
      t.uuid :menu_item_id
      t.uuid :category_id

      t.timestamps
    end
  end
end
