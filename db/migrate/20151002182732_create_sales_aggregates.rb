class CreateSalesAggregates < ActiveRecord::Migration
  def change
    create_table :sales_aggregates, id: :uuid do |t|
      t.uuid :menu_item_id
      t.integer :sale_count, default: 0
      t.integer :sales_amount_total, default: 0

      t.timestamps
    end
  end
end
