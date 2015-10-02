class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: :uuid do |t|
      t.integer :amount_in_cents, null: false, default: 0
      t.uuid :customer_id
      t.uuid :barista_id
      t.string :status, default: 'OPEN'

      t.timestamps null: false
    end
  end
end
