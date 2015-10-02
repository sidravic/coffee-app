class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items, id: :uuid do |t|
      t.uuid :menu_item_id
      t.uuid :order_id

      t.timestamps
    end
  end
end
