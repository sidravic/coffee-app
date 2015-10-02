class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers, id: :uuid do |t|
      t.string :name
      t.string :email_id
      t.string :phone_number

      t.timestamps
    end
  end
end
