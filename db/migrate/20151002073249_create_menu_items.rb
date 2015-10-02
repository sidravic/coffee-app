class CreateMenuItems < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :menu_items, id: :uuid do |t|
      t.string :name
      t.integer :price_in_cents, default: 2_00, null: false

      t.timestamps
    end

    add_index(:menu_items, :name)
  end
end
